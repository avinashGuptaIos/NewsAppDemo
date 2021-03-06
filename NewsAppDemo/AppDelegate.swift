//
//  AppDelegate.swift
//  NewsAppDemo
//
//  Created by hasher on 11/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static func shared() -> AppDelegate {
         DispatchQueue.main.sync {
             let delegate = UIApplication.shared.delegate as! AppDelegate
             return delegate
         }
     }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpInternetConnectionSettings()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate{
    //MARK: SET_UP_FOR_Internet_Connection
           
       func setUpInternetConnectionSettings() {
           
           let reachability = try! Reachability()
           reachability.whenReachable = { reachability in
               NotificationCenter.default.post(name: NSNotification.Name.INTERNET_CONNECTION, object: nil)
           }
           reachability.whenUnreachable = { _ in
               SHOW_TOAST("No internet connection")
           }
           
           do {
               try reachability.startNotifier()
           } catch {
               print("Unable to start notifier")
           }
       }
}
