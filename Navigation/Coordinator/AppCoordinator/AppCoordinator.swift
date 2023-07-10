//
//  AppCoordinator.swift
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
        let profileCoordinator = ProfileCoordinator(window: self.window, parentCoordinator: self)
        let loginVM = LoginVM()
        let loginVC = LogInViewController(coordinator: profileCoordinator, viewModel: loginVM)

        window?.rootViewController = loginVC
        profileCoordinator.openLoginVC()

    }

    func openProfile() {
        self.window?.rootViewController = tabbar
        let profileCoordinator = ProfileCoordinator(window: self.window, parentCoordinator: self)
        profileCoordinator.openProfile()
    }
}
