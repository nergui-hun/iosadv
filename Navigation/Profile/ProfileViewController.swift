//
//  ProfileViewController.swift
//  Navigation
//
//  Created by M M on 3/23/22.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {

    private let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .white

        self.view.addSubview(profileHeaderView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.backgroundColor = .lightGray
        profileHeaderView.layer.borderColor = UIColor.black.cgColor
        profileHeaderView.layer.borderWidth = 1
        profileHeaderView.frame = super.view.frame

        print(profileHeaderView.safeAreaInsets)
    }
}
