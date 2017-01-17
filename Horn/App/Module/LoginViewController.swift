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
import WebKit
import AwesomeCache

class LoginViewController: BaseViewController {
    
    var url: String = ""
    var webView: GMWebComponent?
    
    override func initController() {
        url = Constants.Web.login
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        webView = GMWebComponent(delegate: self, path: self.url)
        addComponent(webView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Login"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension LoginViewController: WebViewDelegate {
    
    func handleLinkTap(url: String) -> Bool {
        if(url == Constants.Web.organizationsRoot){
            do {
                let cache = try Cache<NSString>(name: "hornCache")
                cache.setObject("success", forKey: "login", expires: .never)
            } catch _ {
                debugLog("Something went wrong :(")
            }
            AppDelegate.shareInstance().showMainView()
            return false
        }else{
            return true
        }
    }
    
}
