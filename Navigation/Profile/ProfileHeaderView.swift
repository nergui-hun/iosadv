//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by M M on 4/3/22.
//

import Foundation
import UIKit
import SnapKit

class ProfileHeaderView: UIView {

    //================================VIEW ELEMENTS===============================//
    /*
     1. private let statusLabel: UILabel
     2. private let statusTextField: UITextField
     3. private let avatarImageView: UIImageView
     4. private let fullNameLabel: UILabel
     5. private lazy var setStatusButton: UIButton
     6. lazy var alphaView: UIView
     7. private let closeButton: UIButton
     */
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Waiting for something..."
        label.translatesAutoresizingMaskIntoConstraints = false
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

    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bald")
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = avatarImageViewSize / 2
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
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

    lazy var alphaView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let closePhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "x.square.fill"), for: .normal)
        button.backgroundColor = .red
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.tintColor = .white
        button.addTarget(ProfileHeaderView.self, action: #selector(zoomOutUserPhoto), for: .touchUpInside)
        button.isHidden = true
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    //=============================GESTURES===================================//
    private lazy var tap: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(cancelEditing))
        tapGesture.cancelsTouchesInView = false
        return tapGesture
    }()

    //============================CONSTRAINTS=================================//
    private var statusButtonTopConstraint: NSLayoutConstraint?
    private var avatarLeftTopConstraint: Constraint? = nil
    private let avatarImageViewSize: CGFloat = 130
    let spacing: CGFloat = 16


    //===========================INITIALIZERS=================================//
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //==========================METHODS==================================//
    /*
     1. private func setConstraints()
     2. private func addElements()
     3. @objc func buttonPressed(_ sender: UIButton!)
     4. func zoomInUserPhoto()
     5. @objc func zoomOutUserPhoto(vc: UIViewController)
     6. @objc func showClosePhotoButton()
     7. @objc func hideClosePhotoButton() 
     8. @objc func cancelEditing()
     */
    private func setConstraints() {

        avatarImageView.snp.makeConstraints { make in
            self.avatarLeftTopConstraint = make.left.top.equalToSuperview().offset(spacing).constraint
            make.size.equalTo(avatarImageViewSize)
        }

        self.statusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 20)
        self.statusButtonTopConstraint?.priority = UILayoutPriority(998)

        let labelsLeftSpace = spacing + avatarImageViewSize

        NSLayoutConstraint.activate([
            fullNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: labelsLeftSpace),
            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 30),
            fullNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -spacing),

            setStatusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: spacing),
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
            statusTextField.heightAnchor.constraint(equalToConstant: 30)
        ].compactMap({ $0 }))
    }

    private func addElements() {
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(fullNameLabel)
        self.addSubview(setStatusButton)
        self.addSubview(alphaView)
        self.addSubview(avatarImageView)
        avatarImageView.addSubview(closePhotoButton)
        self.addGestureRecognizer(tap)
    }
    

    @objc func buttonPressed(_ sender: UIButton!) {

        let statusButtonTitle: String = sender.currentTitle!
        if(statusButtonTitle == "Show status") {

            sender.setTitle("Set status", for: .normal)
            self.statusButtonTopConstraint?.isActive = false
            self.statusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant:  40)
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
            self.statusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant:  20)
            NSLayoutConstraint.activate([self.statusButtonTopConstraint].compactMap({ $0 }))
            statusTextField.isHidden = true
        }
    }

    func setAlphaViewConstraints(vc: UIViewController) {
        alphaView.pin(to: vc.view)
    }

    func zoomInUserPhoto(vc: UIViewController) {
        let enlargedAvatarImageViewSize = UIScreen.main.bounds.width > UIScreen.main.bounds.width ?
        UIScreen.main.bounds.height : UIScreen.main.bounds.width

        self.avatarLeftTopConstraint?.deactivate()

        avatarImageView.snp.remakeConstraints{ make in
            make.center.equalTo(alphaView)
            make.size.equalTo(enlargedAvatarImageViewSize)
        }

        closePhotoButton.snp.makeConstraints{ make in
            make.right.top.equalToSuperview()
            make.size.equalTo(50)
        }

        alphaView.alpha = 0.8
        avatarImageView.layer.cornerRadius = 0
    }

    @objc func zoomOutUserPhoto(vc: UIViewController) {

        alphaView.alpha = 0
        avatarImageView.layer.cornerRadius = avatarImageViewSize / 2
        closePhotoButton.isHidden = true

        self.avatarLeftTopConstraint?.activate()
        avatarImageView.snp.remakeConstraints{ make in
            make.size.equalTo(avatarImageViewSize)
        }
    }

    @objc func showClosePhotoButton() {
        closePhotoButton.isHidden = false
        closePhotoButton.alpha = 1
    }

    @objc func hideClosePhotoButton() {
        closePhotoButton.alpha = 0
    }

    @objc func cancelEditing() {
        self.endEditing(true)
    }
}
