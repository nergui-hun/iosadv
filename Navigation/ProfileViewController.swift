//
//  ProfileViewController.swift
//  Navigation
//
//  Created by M M on 3/23/22.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        title = "Profile"
        self.tabBarItem.image = UIImage(systemName: "person")
        view.backgroundColor = .cyan
    }
}
