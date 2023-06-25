//
//  NavFactory.swift
//  Navigation
//
//  Created by M M on 7/31/22.
//

import Foundation
import UIKit

final class NavFactory {
    enum Tab {
        case feed
        case profile
        case saved
        case map
    }

    let navCon: UINavigationController
    let tab: Tab
    let profileVM = ProfileVM()

    init(navCon: UINavigationController, tab: Tab) {
        self.navCon = navCon
        self.tab = tab
        startModule()
    }

    func startModule() {

        let vc: UIViewController

        switch tab {
            case .feed:
                vc = FeedViewController()
                navCon.tabBarItem.title = "Feed"
            case .profile:
                vc = ProfileViewController(viewModel: profileVM)
                navCon.tabBarItem.title = "Profile"
            case .saved:
                vc = SavedViewController()
                navCon.tabBarItem.title = "Saved"
            case .map:
                vc = MapViewController()
            navCon.tabBarItem.title = "Map"
            }

            navCon.setViewControllers([vc], animated: true)
    }
}
