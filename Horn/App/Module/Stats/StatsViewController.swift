//
//  StatsViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/8.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class StatsViewController: BaseViewController, WebViewDelegate {
    
    var url:String = ""
    var webView: GMWebComponent?
    
    override func initController() {
        url = Constants.Web.stats
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Stats"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = GMWebComponent(delegate: self, path: self.url)
        webView!.view.frame = self.view.bounds
        self.addComponent(webView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
