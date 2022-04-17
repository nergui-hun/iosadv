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
        
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        
        setupView()
    }
    
    func setupView() {
        let postButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 4
            button.layer.shadowOffset = CGSize(width: 4, height: 4)
            button.layer.shadowRadius = 4
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.7
            button.tintColor = .white
            button.setTitle("Post button", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.postButtonAction(_:)), for: .touchUpInside)
            return button
        }()
        
        let anotherPostButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 4
            button.layer.shadowOffset = CGSize(width: 4, height: 4)
            button.layer.shadowRadius = 4
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.7
            button.tintColor = .white
            button.setTitle("Another post button", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.postButtonAction(_:)), for: .touchUpInside)
            return button
        }()
        
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.spacing = 10
            stack.distribution = .fillEqually
            stack.axis = .vertical
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(postButton)
            stack.addArrangedSubview(anotherPostButton)
            return stack
        }()
        view.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            postButton.heightAnchor.constraint(equalToConstant: 50),
            anotherPostButton.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ].compactMap({ $0 }))
        
    }
    
    @objc func postButtonAction(_ sender: UIButton!) {
        let postViewController = PostViewController()
        postViewController.post = myPost
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
