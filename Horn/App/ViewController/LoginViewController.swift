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

class LoginViewController: BaseWebViewController {
    
    override func initController() {
        url = Constants.Host+Constants.Web.Login
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Login"
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        debugLog(request.URL?.absoluteString)
        if(request.URL?.absoluteString == Constants.Host+Constants.Web.Root){
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
