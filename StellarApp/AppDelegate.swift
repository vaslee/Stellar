//
//  AppDelegate.swift
//  StellarApp
//
//  Created by TingxinLi on 4/5/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //let SMVC = SolarViewController() // TODO: storyboard instance
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let SMVC = storyboard.instantiateViewController(withIdentifier: "SolarViewController") as! SolarViewController
        
        let NVC = NewsViewController()
        let tab = UITabBarController()
        let nav = UINavigationController.init(rootViewController: SMVC)
        let nav1 = UINavigationController.init(rootViewController: NVC)
        nav.tabBarItem = UITabBarItem(title: "Solar System", image: UIImage.init(named: "icons8-planet-25"), selectedImage: UIImage.init(named: "icons8-planet-25"))
        nav1.tabBarItem = UITabBarItem(title: "Space News", image: UIImage.init(named: "icons8-news-25"), selectedImage: UIImage.init(named: "icons8-news-25"))
        tab.viewControllers = [nav, nav1]
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tab
        window?.makeKeyAndVisible()
    
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
