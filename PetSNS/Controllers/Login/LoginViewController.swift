//
//  LoginViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet private weak var mailAddressTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var passwordForgotButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginButton()
        setupTextField()
        
    }
    
    private func setupLoginButton() {
        loginButton.alpha = 0.5
        loginButton.isEnabled = false
    }
    
    private func setupTextField() {
        mailAddressTextField.delegate = self
        passwordTextField.delegate = self

        let eyeButton = UIButton()
        eyeButton.setBackgroundImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
        
        eyeButton.addTarget(self,
                            action: #selector(eyeButtonDidTouchUpInside),
                            for: .touchUpInside)
        eyeButton.addTarget(self,
                            action: #selector(eyeButtonDidTouchDown),
                            for: .touchDown)

    }
    
    @objc private func eyeButtonDidTouchDown() {
        passwordTextField.isSecureTextEntry = false
    }
    
    @objc private func eyeButtonDidTouchUpInside() {
        passwordTextField.isSecureTextEntry = true
    }


    @IBAction private func loginButtonDidTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction private func passwordForgotButtonDidTapped(_ sender: Any) {
        let passwordForgotVC = PasswordForgotViewController.instantiate()
        self.navigationController?.pushViewController(passwordForgotVC, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let isInput = validate(mail: mailAddressTextField.text,
                                          pass: passwordTextField.text)
        if isInput {
            loginButton.alpha = 1
            loginButton.isEnabled = true
        }
        else {
            loginButton.alpha = 0.5
            loginButton.isEnabled = false
        }
        
    }
    
    private func validate(mail: String?, pass: String?) -> Bool {
        guard mail != nil,
              mail?.isEmpty == false,
              pass != nil,
              pass?.isEmpty == false else { return false }
        return true
    }

}
