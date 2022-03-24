//
//  FeedViewController.swift
//  Navigation
//
//  Created by M M on 3/20/22.
//

import Foundation
import UIKit

struct Post {
    let title: String
}

class FeedViewController: UIViewController {

    let myPost = Post(title: "My post")

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Feed"
        self.tabBarItem.image = UIImage(systemName: "newspaper")
        view.backgroundColor = .systemGray6

        let postButton = UIButton(type: UIButton.ButtonType.system)
        postButton.setTitle("Posts", for: .normal)
        postButton.setTitleColor(.white, for: .normal)
        postButton.backgroundColor = .systemTeal
        postButton.frame = CGRect(x: 10, y: 90, width: 150, height: 50)
        postButton.layer.cornerRadius = 20
        postButton.addTarget(self, action: #selector(self.postButtonAction), for: .touchUpInside)

        self.view.addSubview(postButton)
    }

    @IBAction func postButtonAction(_ sender: UIButton!) {
        let postViewController = PostViewController()
        postViewController.post = myPost
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
