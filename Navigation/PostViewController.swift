//
//  PostViewController.swift
//  Navigation
//
//  Created by M M on 3/20/22.
//

import Foundation
import UIKit

class PostViewController: UIViewController {

    var post = Post(title: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func newInfoViewController() {
        let newInfoViewController = InfoViewController()
        newInfoViewController.title = "Info"
        self.navigationController?.pushViewController(newInfoViewController, animated: true)
    }

    private func setupView() {
        self.title = post.title
        view.backgroundColor = .white
        let infoBarButtonItem = UIBarButtonItem(title: "News", style: .plain, target: self, action: #selector(self.newInfoViewController))
        self.navigationItem.rightBarButtonItem = infoBarButtonItem
    }
}
