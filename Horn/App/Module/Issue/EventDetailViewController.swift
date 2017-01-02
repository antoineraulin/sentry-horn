//
//  EventDetailViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/8.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class EventDetailViewController: BaseViewController,WebViewProtocol {

    var url:String = ""
    var webView:WebViewComponent?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Event Detail"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WebViewComponent(adapter: self, url: self.url)
        webView!.view.frame = self.view.bounds
        self.addComponent(webView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
