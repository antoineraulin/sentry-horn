//
//  BaseWebViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/8.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

@objc protocol WebViewProtocol{
    @objc optional func webViewDidStartLoad(_ webView: UIWebView)
    @objc optional func webViewDidFinishLoad(_ webView: UIWebView)
    @objc optional func webView(_ webView: UIWebView, didFailLoadWithError error: NSError?)
    @objc optional func webView(_ webView: UIWebView, shouldStartLoadWithRequest request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
}

class WebViewComponent: BaseViewController, UIWebViewDelegate {
    
    fileprivate var url:String = ""
    fileprivate var adapter:WebViewProtocol?
    fileprivate let webView:UIWebView = UIWebView(frame: CGRect.zero)
    
    convenience init(adapter:WebViewProtocol, url:String) {
        self.init()
        self.url = url
        self.adapter = adapter
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        webView.frame = self.view.bounds
        webView.scrollView.contentSize.width = _viewWidth
        webView.delegate=self
        webView.scalesPageToFit = true;
        self.view.addSubview(webView)
        webView.loadRequest(URLRequest(url: URL(string: url)!))
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.showLoading()
        self.adapter?.webViewDidStartLoad?(webView)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        self.hideLoading()
        self.adapter?.webViewDidFinishLoad?(webView)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.hideLoading()
        if (error._code == NSURLErrorCancelled){
            debugLog(self.webView.request?.url?.absoluteString)
        }
        self.adapter?.webView?(webView, didFailLoadWithError: error as NSError?)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        debugLog(request.url?.absoluteString)
        if let shouldStart = self.adapter?.webView?(webView, shouldStartLoadWithRequest: request, navigationType: navigationType){
            return shouldStart
        }else{
            return true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

