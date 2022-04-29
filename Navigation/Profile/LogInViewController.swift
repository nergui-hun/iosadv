//
//  LogInViewController.swift
//  Navigation
//
//  Created by M M on 4/25/22.
//

import Foundation
import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }

    @objc func redirectProfile() {
        let profileViewController = ProfileViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        self.tabBarController?.viewControllers?[1] = profileNavigationController
    }

    @objc func cancelEditing() {
        emailPhoneTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }


    private func setupView() {
        title = "Profile"
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5

        view.addSubview(logoImage)
        logInTextFieldsStackView.addArrangedSubview(emailPhoneTextField)
        logInTextFieldsStackView.addArrangedSubview(passwordTextField)

        contentView.addSubview(logInTextFieldsStackView)
        logInTextFieldsScrollView.addSubview(contentView)
        view.addSubview(logInTextFieldsScrollView)
        view.addSubview(logInButton)


        view.addGestureRecognizer(tap)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 120),
            logoImage.widthAnchor.constraint(equalToConstant: 120),

            logInTextFieldsStackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            logInTextFieldsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            logInTextFieldsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            logInTextFieldsStackView.heightAnchor.constraint(equalToConstant: 100),

            logInButton.topAnchor.constraint(equalTo: logInTextFieldsStackView.bottomAnchor, constant: 16),
            logInButton.leftAnchor.constraint(equalTo: logInTextFieldsStackView.leftAnchor),
            logInButton.rightAnchor.constraint(equalTo: logInTextFieldsStackView.rightAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ].compactMap({ $0 }))
    }

    //================================OBSERVERS===============================//

    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            logInTextFieldsScrollView.contentInset.bottom = kbdSize.height
            logInTextFieldsScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }

    @objc func kbdHide(notification: NSNotification) {
        logInTextFieldsScrollView.contentInset.bottom = .zero
        logInTextFieldsScrollView.verticalScrollIndicatorInsets = .zero
    }

//================================VIEW ELEMENTS===============================//

    let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    } ()

    let emailPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        textField.placeholder = "Email or phone"
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        textField.placeholder = "Password"
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()

    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel.png"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10

        if button.isSelected || button.isHighlighted || !button.isEnabled{
            button.alpha = 0.8
        } else {
            button.alpha = 1
        }

        button.addTarget(self, action: #selector(redirectProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var contentView: UIView = {
        let content = UIView()
        content.frame.size = contentViewSize
        return content
    } ()

    let logInTextFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var logInTextFieldsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = contentViewSize
        scrollView.frame = self.view.bounds
        return scrollView
    } ()

    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)

    //==============================GESTURES==================================//


    private lazy var tap: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(cancelEditing))
        tapGesture.cancelsTouchesInView = false
        return tapGesture
    }()
}
