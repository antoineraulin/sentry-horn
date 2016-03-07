//
//  MainViewController.swift
//  Achilles
//
//  Created by Thierry on 8/29/15.
//  Copyright (c) 2015 Thierry. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController,UITabBarControllerDelegate {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.delegate = self
        
        let dashboard: DashboardViewController = DashboardViewController()
        dashboard.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(named:"Dashboard"), selectedImage: UIImage(named: "DashboardFill"))
        
        let projects: ProjectListViewController = ProjectListViewController()
        projects.tabBarItem = UITabBarItem(title: "Projects", image: UIImage(named:"Daily"), selectedImage: UIImage(named: "DailyFill"))
        
        self.setViewControllers([dashboard,projects], animated: false)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleLoginExpired"), name: Constants.Notification.LoginExpired, object: nil)
        
    }
    
    func handleLoginExpired(){
        AppDelegate.shareInstance().showLoginView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        // perform the deinitialization
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
