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
        
        view.backgroundColor = .lightGray
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1

        let postButton = UIButton(type: UIButton.ButtonType.system)
        postButton.setTitle("Posts", for: .normal)
        postButton.setTitleColor(.white, for: .normal)
        postButton.backgroundColor = .systemBlue
        postButton.frame = CGRect(x: 16, y: 380, width: UIScreen.main.bounds.width - 16 - 16, height: 50)
        postButton.layer.cornerRadius = 4

        postButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        postButton.layer.shadowRadius = 4
        postButton.layer.shadowColor = UIColor.black.cgColor
        postButton.layer.shadowOpacity = 0.7

        postButton.addTarget(self, action: #selector(self.postButtonAction), for: .touchUpInside)

        self.view.addSubview(postButton)
    }

    @IBAction func postButtonAction(_ sender: UIButton!) {
        let postViewController = PostViewController()
        postViewController.post = myPost
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
