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
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.isTranslucent = false

        feedNavigationController.setViewControllers([feedViewController], animated: true)
        feedNavigationController.tabBarItem.image = UIImage(systemName: "house.fill")
        feedNavigationController.navigationBar.isTranslucent = false
        feedNavigationController.navigationBar.barTintColor = .white
        
        profileNavigationController.setViewControllers([profileViewController], animated: true)
        profileNavigationController.tabBarItem.image = UIImage(systemName: "person.fill")
        

        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = .white
        print(tabBarController.tabBar.bounds.height)
        print(profileNavigationController.navigationBar.bounds.height)
        
        self.window?.makeKeyAndVisible()
        return true
    }

}

