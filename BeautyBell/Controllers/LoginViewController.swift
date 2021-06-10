//
//  ViewController.swift
//  BeautyBell
//
//  Created by Jacob Andrean on 10/06/21.
//

import UIKit

class LoginViewController: UIViewController {

    private let loginManualLabel: UILabel = {
        let label = UILabel()
        label.text = "Login Manual"
        label.textAlignment = .center
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .bezel
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .bezel
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        return button
    }()
    
    private let loginViaSosMedLabel: UILabel = {
        let label = UILabel()
        label.text = "Login via Social Media"
        label.textAlignment = .center
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let googleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Google Login", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        return button
    }()
    
    private let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Facebook Login", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .systemBackground
        view.addSubview(loginManualLabel)
        view.addSubview(nameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(loginViaSosMedLabel)
        view.addSubview(googleLoginButton)
        view.addSubview(facebookLoginButton)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        googleLoginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        facebookLoginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.frame = CGRect(
            x: 150,
            y: view.height/2-50,
            width: view.width-300,
            height: 50
        )
        
        passwordTextField.frame = CGRect(
            x: 90,
            y: loginButton.top-60,
            width: view.width-180,
            height: 40
        )

        nameTextField.frame = CGRect(
            x: 90,
            y: passwordTextField.top-60,
            width: view.width-180,
            height: 40
        )

        loginManualLabel.frame = CGRect(
            x: 90,
            y: nameTextField.top-70,
            width: view.width-180,
            height: 40
        )
        
        loginViaSosMedLabel.frame = CGRect(
            x: 90,
            y: view.height/2+50,
            width: view.width-180,
            height: 40
        )
        
        googleLoginButton.frame = CGRect(
            x: 90,
            y: loginViaSosMedLabel.bottom+30,
            width: view.width-180,
            height: 70
        )
        
        facebookLoginButton.frame = CGRect(
            x: 90,
            y: googleLoginButton.bottom+20,
            width: view.width-180,
            height: 70
        )
    }

    @objc private func didTapLogin() {
        print("hmm")
        let userDefault = UserDefaults.standard
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true) {
            userDefault.setValue(true, forKey: "IsSignedIn")
        }
    }
}

