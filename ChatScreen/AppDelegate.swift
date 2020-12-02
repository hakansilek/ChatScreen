//
//  AppDelegate.swift
//  ChatScreen
//
//  Created by Hakan Silek on 27.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        let viewController = ChatViewController()
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
}

