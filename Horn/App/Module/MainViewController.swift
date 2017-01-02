//
//  MainViewController.swift
//  Achilles
//
//  Created by Thierry on 8/29/15.
//  Copyright (c) 2015 Thierry. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        let dashboard: DashboardViewController = DashboardViewController()
        dashboard.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(named:"Dashboard"), selectedImage: UIImage(named: "DashboardFill"))
        
        let projects: ProjectListViewController = ProjectListViewController()
        projects.tabBarItem = UITabBarItem(title: "Projects", image: UIImage(named:"Projects"), selectedImage: UIImage(named: "ProjectsFill"))
        
        let issues: IssuesViewController = IssuesViewController()
        issues.tabBarItem = UITabBarItem(title: "Issues", image: UIImage(named:"Issues"), selectedImage: UIImage(named: "IssuesFill"))
        
        let stats: StatsViewController = StatsViewController()
        stats.tabBarItem = UITabBarItem(title: "Stats", image: UIImage(named:"Stats"), selectedImage: UIImage(named: "StatsFill"))
        
        let account: AccountViewController = AccountViewController()
        account.tabBarItem = UITabBarItem(title: "Account", image: UIImage(named:"Account"), selectedImage: UIImage(named: "AccountFill"))
        
        self.setViewControllers([dashboard,issues,projects,stats,account], animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.handleLoginExpired), name: NSNotification.Name(rawValue: Constants.Notification.LoginExpired), object: nil)
        
    }
    
    func handleLoginExpired(){
        AppDelegate.shareInstance().showLoginView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
