//
//  AppDelegate.swift
//  Coffee Break
//
//  Created by Eric Garcia on 5/11/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let primaryColor = UIColor(red: 64/255, green: 50/255, blue: 24/255, alpha: 1)
    let accentColor = UIColor(red: 166/255, green: 160/255, blue: 129/255, alpha: 1)
    let actionColor = UIColor(red: 255/255, green: 101/255, blue: 0/255, alpha: 1)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        setStyle()
        return true
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

extension AppDelegate {
    
    func setStyle() {
        // Set status bar text to white
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        let navBarAppearance = UINavigationBar.appearance()
        
        // Navbar color
        navBarAppearance.barTintColor = primaryColor
        // Navbar text color
        navBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName: accentColor]
        // Navbar action color
        navBarAppearance.tintColor = actionColor
    }
}

