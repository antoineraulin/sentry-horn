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

class LoginViewController: BaseViewController,WebViewProtocol {
    
    var url:String = ""
    var webView:WebViewComponent?
    
    override func initController() {
        url = Constants.Web.Login
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WebViewComponent(adapter: self, url: self.url)
        webView!.view.frame = self.view.bounds
        self.addComponent(webView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Login"
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWithRequest request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        debugLog(request.url?.absoluteString)
        if(request.url?.absoluteString == Constants.Web.OrganizationsRoot){
            AppDelegate.shareInstance().showMainView()
            return false
        }else{
            return true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
