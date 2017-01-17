//
//  BaseWebViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/8.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

import UIKit
import WebKit
import EVReflection
import SwiftyJSON

@objc protocol WebViewDelegate {
    
    @objc optional func handleLinkTap(url: String) -> Bool
    
    @objc optional func handleResponse(navigationResponse: WKNavigationResponse)
    
}

class GMWebComponent: BaseViewController {
    
    var configuration = WKWebViewConfiguration()
    var path: String = ""
    
    weak var delegate: WebViewDelegate?
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    convenience init(delegate: WebViewDelegate, path: String) {
        self.init()
        self.path = path
        self.delegate = delegate
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        initWebView()
        initProgressView()
        addObserver()
        sendRequest()
    }
    
    /**
     初始化WebView
     */
    private func initWebView() {
        // Sync Cookie Between Different WebView Instances
        configuration.processPool = CookieSyncManger.sharedInstance.processPool
        webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    func initProgressView() {
        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.bar)
        progressView.progressTintColor = UIColor(rgba: Color.blue)
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(1)
        }
    }
    
    /**
     Send Request
     */
    private func sendRequest() {
        let request = NSMutableURLRequest(url: NSURL(string: self.path)! as URL)
        webView.load(request as URLRequest)
    }
    
    func addObserver() {
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            self.title = webView.title
            if self.parent != nil {
                self.parent?.title = webView.title
            }
        } else if keyPath == "estimatedProgress" {
            if let currentProgress = change?[NSKeyValueChangeKey(rawValue: "new")] as? Float {
                debugLog(currentProgress)
                progressView.setProgress(currentProgress, animated: true)
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
    }
}


extension GMWebComponent: WKNavigationDelegate {
    
    /**
     Start Request
     */
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        debugLog("didStartProvisionalNavigation")
        progressView.isHidden = false
    }
    
    /**
     Request Finished
     */
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }
    
    /**
     Dom Load Finished
     */
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        delay(delay: 0.5) {
            self.progressView.isHidden = true
        }
    }
    
    /**
     URL Before Redirect
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        debugLog("navigationAction\(navigationAction.request.url) \(navigationAction.request.httpMethod)")
        if let url =  navigationAction.request.url {
            if let allowNavigate = delegate?.handleLinkTap?(url: url.absoluteString) {
                if allowNavigate {
                    decisionHandler(.allow)
                } else {
                    decisionHandler(.cancel)
                }
            } else {
                decisionHandler(.allow)
            }
        } else {
            decisionHandler(.allow)
        }
    }
    
    /**
     URL Get Response
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        debugLog("navigationResponse\(navigationResponse.response.url) \((navigationResponse.response as! HTTPURLResponse).statusCode)")
        delegate?.handleResponse?(navigationResponse: navigationResponse)
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
    }
    
}


// MARK: - WKUIDelegate
extension GMWebComponent: WKUIDelegate {
    
    // WebView Alert Handler
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let ac = UIAlertController(title: webView.title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (aa) -> Void in
            
        }))
        self.present(ac, animated: true, completion: nil)
    }
    
    // WebView Confirm Handler
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let ac = UIAlertController(title: webView.title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (aa) -> Void in
            
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (aa) -> Void in
        }))
        self.present(ac, animated: true, completion: nil)
    }
    
}


// MARK: - WKScriptMessageHandler
extension GMWebComponent: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        debugLog(message.body)
    }
    
}
