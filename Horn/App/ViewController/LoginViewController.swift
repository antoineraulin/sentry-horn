//
//  LoginViewController.swift
//  Achilles
//
//  Created by Thierry on 15/10/24.
//  Copyright © 2015年 Thierry. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON

class LoginViewController: BaseViewController, UIWebViewDelegate {

    let webView:UIWebView = UIWebView(frame: CGRectZero)
    let url:NSURL = NSURL(string: Constants.Host+Constants.Web.Login)!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Login"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        webView.frame = CGRectMake(0, 0, _viewWidth, _viewHeight - _tabHeight - _naviHeight)
        webView.delegate=self
        webView.scalesPageToFit = true;
        self.view.addSubview(webView)
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        debugLog(request.URL?.absoluteString)
        if(request.URL?.absoluteString == Constants.Host+Constants.Web.Root){
            AppDelegate.shareInstance().showOrgView()
            return false
        }else{
            return true
        }
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
