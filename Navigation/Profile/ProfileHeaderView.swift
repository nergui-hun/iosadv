//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by M M on 4/3/22.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {

    private let statusLabel = UILabel()
    private let statusTextField = UITextField()
    private let avatarImageView = UIImageView()
    private let fullNameLabel = UILabel()
    private let setStatusButton = UIButton(type: .system)
    private let setTitleButton = UIButton(type: .system)

    private var statusButtonTopConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)

        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.backgroundColor = .lightGray
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        statusLabel.text = "Waiting for something..."
        self.addSubview(statusLabel)

        statusTextField.frame = CGRect()
        statusTextField.backgroundColor = .white
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.isHidden = true
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(statusTextField)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(cancelEditing))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)

        avatarImageView.image = UIImage(named: "bald")
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.cornerRadius = 65
        avatarImageView.contentMode = UIView.ContentMode.scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(avatarImageView)

        fullNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        fullNameLabel.textColor = .black
        fullNameLabel.text = "Bald Cat"
        fullNameLabel.numberOfLines = 0
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fullNameLabel)

        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.tintColor = .white
        setStatusButton.setTitle("Show status", for: .normal)
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        self.addSubview(setStatusButton)

        setTitleButton.backgroundColor = .systemBlue
        setTitleButton.layer.cornerRadius = 4
        setTitleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setTitleButton.layer.shadowRadius = 4
        setTitleButton.layer.shadowColor = UIColor.black.cgColor
        setTitleButton.layer.shadowOpacity = 0.7
        setTitleButton.tintColor = .white
        setTitleButton.setTitle("Set title", for: .normal)
        setTitleButton.translatesAutoresizingMaskIntoConstraints = false
        //setTitleButton.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        self.addSubview(setTitleButton)

        self.statusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16)
        self.statusButtonTopConstraint?.priority = UILayoutPriority(999)

        NSLayoutConstraint.activate([
            avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 130),
            avatarImageView.widthAnchor.constraint(equalToConstant: 130),

            fullNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 30),
            fullNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),

            setStatusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.statusButtonTopConstraint,
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.rightAnchor.constraint(equalTo: fullNameLabel.rightAnchor),

            statusLabel.leftAnchor.constraint(equalTo: fullNameLabel.leftAnchor),
            statusLabel.rightAnchor.constraint(equalTo: fullNameLabel.rightAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 82),
            statusLabel.heightAnchor.constraint(equalToConstant: 30),

            statusTextField.leftAnchor.constraint(equalTo: fullNameLabel.leftAnchor),
            statusTextField.rightAnchor.constraint(equalTo: fullNameLabel.rightAnchor),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 4),
            statusTextField.heightAnchor.constraint(equalToConstant: 30),

            setTitleButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            setTitleButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            setTitleButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            setTitleButton.heightAnchor.constraint(equalToConstant: 50)

        ].compactMap({ $0 }))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

    @objc func buttonPressed(_ sender: UIButton!) {

        let statusButtonTitle: String = sender.currentTitle!
        if(statusButtonTitle == "Show status") {
            if let text = statusLabel.text {
                print(text)
            }

            sender.setTitle("Set status", for: .normal)
            self.statusButtonTopConstraint?.isActive = false
            self.statusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant:  36)
            NSLayoutConstraint.activate([self.statusButtonTopConstraint].compactMap({ $0 }))
            self.statusTextField.isHidden = false
            statusTextField.becomeFirstResponder()

        } else {
            if(statusTextField.hasText) {
                statusLabel.text = statusTextField.text
                sender.setTitle("Show status", for: .normal)
                self.statusButtonTopConstraint?.isActive = true
                self.statusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant:  16)
                NSLayoutConstraint.activate([self.statusButtonTopConstraint].compactMap({ $0 }))
                statusTextField.isHidden = true
            }
        }
    }

    @objc func cancelEditing() {
        self.endEditing(true)
        self.setStatusButton.setTitle("Show status", for: .normal)
        self.statusButtonTopConstraint?.isActive = true
        self.statusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant:  16)
        NSLayoutConstraint.activate([self.statusButtonTopConstraint].compactMap({ $0 }))
        statusTextField.isHidden = true
    }
}
