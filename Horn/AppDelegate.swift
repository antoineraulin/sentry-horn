//
//  AppDelegate.swift
//  Horn
//
//  Created by Thierry on 16/3/5.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject:AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        self.initNetWorking()
        self.checkLoginStatus()
        return true
    }
    
    class func shareInstance() -> AppDelegate
    {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    func initNetWorking() {
        let service: GMNetService = GMNetService.sharedInstance
        service.apiHost = Constants.Host;
    }
    
    func checkLoginStatus(){
        var cookieExpire = true
        let cookies:[NSHTTPCookie] = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(NSURL(string: Constants.Host)!)!
        for cookie in cookies {
            if cookie.name == "sentrysid" {
                let result = cookie.expiresDate?.compare(NSDate())
                if result == NSComparisonResult.OrderedDescending{
                    cookieExpire = false
                }
            }
        }
        if cookieExpire{
            self.showLoginView()
        }else{
            self.showOrgView()
        }
    }
    
    func showOrgView() {
        let org = OrganizationListViewController()
        let navi = UINavigationController(rootViewController: org)
        self.window!.rootViewController = navi
    }
    
    func showMainView() {
        let main = MainViewController()
        let navi = UINavigationController(rootViewController: main)
        self.window!.rootViewController = navi
    }
    
    func showLoginView(){
        self.cleanCookie()
        let login = LoginViewController()
        let navi = UINavigationController(rootViewController: login)
        self.window!.rootViewController = navi
    }
    
    func cleanCookie(){
        let cookies:[NSHTTPCookie] = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(NSURL(string: Constants.Host)!)!
        for cookie in cookies {
            NSHTTPCookieStorage.sharedHTTPCookieStorage().deleteCookie(cookie)
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

