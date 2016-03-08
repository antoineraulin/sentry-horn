//
//  StatsViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/8.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class StatsViewController: BaseWebViewController {
    
    override func initController() {
        url = Constants.Host+Constants.Web.Stats
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Stats"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
