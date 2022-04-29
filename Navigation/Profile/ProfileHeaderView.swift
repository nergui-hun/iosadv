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
        addSubviews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {

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

    private func addSubviews() {
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addGestureRecognizer(tap)
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(setStatusButton)
        self.addSubview(setTitleButton)
        self.statusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16)
        self.statusButtonTopConstraint?.priority = UILayoutPriority(999)
    }
    

    @objc func buttonPressed(_ sender: UIButton!) {

        let statusButtonTitle: String = sender.currentTitle!
        if(statusButtonTitle == "Show status") {

            sender.setTitle("Set status", for: .normal)
            self.statusButtonTopConstraint?.isActive = false
            self.statusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant:  36)
            NSLayoutConstraint.activate([self.statusButtonTopConstraint].compactMap({ $0 }))
            self.statusTextField.isHidden = false
            statusTextField.text = statusLabel.text
            statusTextField.becomeFirstResponder()

        } else {
            statusLabel.text = statusTextField.text
            sender.setTitle("Show status", for: .normal)

            self.endEditing(true)
            self.setStatusButton.setTitle("Show status", for: .normal)
            self.statusButtonTopConstraint?.isActive = true
            self.statusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant:  16)
            NSLayoutConstraint.activate([self.statusButtonTopConstraint].compactMap({ $0 }))
            statusTextField.isHidden = true
        }
    }

    @objc func cancelEditing() {
        self.endEditing(true)
    }

//================================VIEW ELEMENTS===============================//

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Waiting for something..."
        return label
    }()

    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect()
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bald")
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 65
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Bald Cat"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.tintColor = .white
        button.setTitle("Show status", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    private let setTitleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.tintColor = .white
        button.setTitle("Set title", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var tap: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(cancelEditing))
        tapGesture.cancelsTouchesInView = false
        return tapGesture
    }()

    private var statusButtonTopConstraint: NSLayoutConstraint?

}
