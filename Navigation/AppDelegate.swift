//
//  AppDelegate.swift
//  Navigation
//
//  Created by M M on 3/19/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        self.window?.rootViewController = tabBarController

        let feedViewController = FeedViewController()
        let profileViewController = ProfileViewController()

        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)

        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]

        feedNavigationController.setViewControllers([feedViewController], animated: true)
        profileNavigationController.setViewControllers([profileViewController], animated: true)
        
        self.window?.makeKeyAndVisible()
        return true
    }

}

