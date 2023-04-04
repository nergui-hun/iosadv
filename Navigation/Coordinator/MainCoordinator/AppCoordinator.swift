//
//  MainCoordinator.swift
//  Navigation
//
//  Created by M M on 7/31/22.
//

import Foundation
import UIKit

protocol AppCoordinatorProtocol {
    func startApp()
}

final class AppCoordinator: AppCoordinatorProtocol {

    let window: UIWindow?
    private let tabbar = MainTabBarViewController()

    init(window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
    }

    func startApp() {
        let loginCoordinator = LoginCoordinator(window: self.window, parentCoordinator: self)
        loginCoordinator.openProfile()
        self.window?.rootViewController = tabbar
    }
}
