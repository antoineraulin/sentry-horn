//
//  BaseWebViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/8.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class BaseWebViewController: BaseViewController, UIWebViewDelegate {
    
    let webView:UIWebView = UIWebView(frame: CGRectZero)
    var url:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.frame = self.view.bounds
        webView.scrollView.contentSize.width = _viewWidth
        webView.delegate=self
        webView.scalesPageToFit = true;
        self.view.addSubview(webView)
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        self.showLoading()
    }
    
    func webViewDidFinishLoad(webView: UIWebView){
        self.hideLoading()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.hideLoading()
        if (error?.code == NSURLErrorCancelled){
            debugLog(webView.request?.URL?.absoluteString)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

