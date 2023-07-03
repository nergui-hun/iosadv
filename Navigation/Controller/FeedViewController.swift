//
//  FeedViewController.swift
//  Navigation
//
//  Created by M M on 3/20/22.
//

import Foundation
import UIKit

final class FeedViewController: UIViewController {

    // MARK: - Values
    private enum LocalizedKeys: String {
        case postButton = "postButton-localizable"
    }


    // MARK: - View Elements

    let postButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.tintColor = .white
        button.setTitle(String(localized: "postButton-localizable"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(postButtonAction(_:)), for: .touchUpInside)
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
        button.setTitle(String(localized: "anotherPostButton-localizable"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(postButtonAction(_:)), for: .touchUpInside)
        return button
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()


    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = String(localized: "feed-title-localizable")
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        self.navigationController?.navigationBar.isHidden = true

        addElements()
        setupElements()
    }

    private func addElements() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(postButton)
        stackView.addArrangedSubview(anotherPostButton)
    }

    private func setupElements() {
        NSLayoutConstraint.activate([
            postButton.heightAnchor.constraint(equalToConstant: 50),
            anotherPostButton.heightAnchor.constraint(equalToConstant: 50),

            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    @objc func postButtonAction(_ sender: UIButton!) {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
