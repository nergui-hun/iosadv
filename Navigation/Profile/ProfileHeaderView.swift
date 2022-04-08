//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by M M on 4/3/22.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


    let statusLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 170, y: 98, width: 200, height: 30)
        label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Waiting for something..."
        return label
    }()

    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.frame = CGRect(x: 170, y: 128, width: UIScreen.main.bounds.width - 16 - 170, height: 40)
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textView.textColor = .black
        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.isHidden = true
        return textView
    }()

    let tap: UITapGestureRecognizer = UITapGestureRecognizer()


    private func setupView() {

        tap.addTarget(self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false

        let profileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "bald")
            imageView.frame = CGRect(x: 16, y: self.safeAreaInsets.top, width: 130, height: 130)
            imageView.layer.borderWidth = 3
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.cornerRadius = imageView.frame.height/2
            imageView.contentMode = UIView.ContentMode.scaleAspectFill
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = true
            return imageView
        }()

        let userNameLabel: UILabel = {
            let label = UILabel()
            label.frame = CGRect(x: 170, y: 27, width:  UIScreen.main.bounds.width - 16 - 170, height: 30)
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.textColor = .black
            label.text = "Bald Cat"
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = true
            return label
        }()

        let showStatusButton: UIButton = {
            let button = UIButton()
            button.frame = CGRect(x: 16, y: 162, width:  UIScreen.main.bounds.width - 16 - 16, height: 50)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 4

            button.layer.shadowOffset = CGSize(width: 4, height: 4)
            button.layer.shadowRadius = 4
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.7

            button.tintColor = .white
            button.setTitle("Show status", for: .normal)

            button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
            return button
        }()

        self.addSubview(profileImageView)
        self.addSubview(userNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(showStatusButton)
        self.addSubview(statusTextView)
        self.addGestureRecognizer(tap)
}
    @objc func buttonPressed(_ sender: UIButton!) {

        let statusButtonTitle: String = sender.currentTitle!
        if(statusButtonTitle == "Show status") {
            if let text = statusLabel.text {
                print(text)
            }

            sender.setTitle("Set status", for: .normal)
            sender.frame = CGRect(x: 16, y: 184, width:  UIScreen.main.bounds.width - 16 - 16, height: 50)
            statusTextView.isHidden = false
            statusTextView.becomeFirstResponder()
        } else {
            if(statusTextView.hasText) {
                statusLabel.text = statusTextView.text
                sender.setTitle("Show status", for: .normal)
                sender.frame = CGRect(x: 16, y: 162, width:  UIScreen.main.bounds.width - 16 - 16, height: 50)
                statusTextView.isHidden = true
            } else {

            }
        }

    }

    @objc func hideKeyboard() {
        self.endEditing(true)
    }
}
