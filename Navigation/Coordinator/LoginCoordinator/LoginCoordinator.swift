//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by M M on 7/31/22.
//

import Foundation
import UIKit

final class LoginCoordinator {

    let parentCoordinator: AppCoordinator
    let profileVM = ProfileVM()
    lazy var profileVC = ProfileViewController(viewModel: self.profileVM)
    let navCon: UINavigationController
    let window: UIWindow?

    init(window: UIWindow?, parentCoordinator: AppCoordinator) {
        self.navCon = .init()
        self.window = window
        self.parentCoordinator = parentCoordinator
    }

    func openProfile() {
        //parentCoordinator.setupTabbar()
        self.navCon.pushViewController(profileVC, animated: true)
    }


    func redirectProfile(navCon: UINavigationController?, coordinator: LoginCoordinator) {
        window?.rootViewController = MainTabBarViewController()
        navCon?.pushViewController(profileVC, animated: true)
    }
}
