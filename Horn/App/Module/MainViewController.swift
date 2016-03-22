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

        self.delegate = self
        
        let dashboard: DashboardViewController = DashboardViewController()
        dashboard.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(named:"Dashboard"), selectedImage: UIImage(named: "DashboardFill"))
        
        let projects: ProjectListViewController = ProjectListViewController()
        projects.tabBarItem = UITabBarItem(title: "Projects", image: UIImage(named:"Projects"), selectedImage: UIImage(named: "ProjectsFill"))
        
        let stats: StatsViewController = StatsViewController()
        stats.tabBarItem = UITabBarItem(title: "Stats", image: UIImage(named:"Stats"), selectedImage: UIImage(named: "StatsFill"))
        
        let settings: SettingsViewController = SettingsViewController()
        settings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named:"Settings"), selectedImage: UIImage(named: "SettingsFill"))
        
        self.setViewControllers([dashboard,projects,stats,settings], animated: false)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.handleLoginExpired), name: Constants.Notification.LoginExpired, object: nil)
        
    }
    
    func handleLoginExpired(){
        AppDelegate.shareInstance().showLoginView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
