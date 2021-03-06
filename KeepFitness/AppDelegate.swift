//
//  AppDelegate.swift
//  KeepFitness
//
//  Created by Apple on 2017/6/3.
//  Copyright © 2017年 nju. All rights reserved.
//

import UserNotifications
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            //func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNUserNotificationCenter, withCompletionHandler completionHandler: @escaping(UNNotificationPresentationOptions) -> Void)
        }
        return true
    }
    
    // app在前台运行时，收到通知会唤起该方法，但是前提是得 实现该方法 及 实现completionHandler
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void){
        print("categoryIdentifier: \(notification.request.content.categoryIdentifier)")
        completionHandler(.alert)
    }
    
    // 用户收到通知点击进入app的时候唤起，
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        let catogoryIdentifier = response.notification.request.content.categoryIdentifier
        if catogoryIdentifier == "local_notification" {
            // 根据事件的 identifier 来响应对应的通知点击事件
            if response.actionIdentifier == "sure_action" {
                print("response.actionIdentifier: sure_action")
            }
        }
        completionHandler()
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

