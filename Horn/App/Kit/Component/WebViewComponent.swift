//
//  BaseWebViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/8.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

@objc protocol WebViewProtocol{
    optional func webViewDidStartLoad(webView: UIWebView)
    optional func webViewDidFinishLoad(webView: UIWebView)
    optional func webView(webView: UIWebView, didFailLoadWithError error: NSError?)
    optional func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
}

class WebViewComponent: BaseViewController, UIWebViewDelegate {
    
    private var url:String = ""
    private var adapter:WebViewProtocol?
    private let webView:UIWebView = UIWebView(frame: CGRectZero)
    
    convenience init(adapter:WebViewProtocol, url:String) {
        self.init()
        self.url = url
        self.adapter = adapter
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        super.didMoveToParentViewController(parent)
        webView.frame = self.view.bounds
        webView.scrollView.contentSize.width = _viewWidth
        webView.delegate=self
        webView.scalesPageToFit = true;
        self.view.addSubview(webView)
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        self.showLoading()
        self.adapter?.webViewDidStartLoad?(webView)
    }
    
    func webViewDidFinishLoad(webView: UIWebView){
        self.hideLoading()
        self.adapter?.webViewDidFinishLoad?(webView)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        self.hideLoading()
        if (error.code == NSURLErrorCancelled){
            debugLog(self.webView.request?.URL?.absoluteString)
        }
        self.adapter?.webView?(webView, didFailLoadWithError: error)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        debugLog(request.URL?.absoluteString)
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

