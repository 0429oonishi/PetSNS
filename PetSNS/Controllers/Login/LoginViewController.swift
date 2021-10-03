//
//  LoginViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

extension LoginViewController: ChangeFrameProtocol { }

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var mailAddressTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var passwordForgotButton: UIButton!
    
    private let indicator = Indicator(kinds: PKHUDIndicator())
    
    private let secureButton = UIButton()
    private var isAllTextFieldInputted: Bool {
        guard let mailText = mailAddressTextField.text,
              let passwordText = passwordTextField.text else { return false }
        return !mailText.isEmpty && !passwordText.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginButton()
        setupMailAddressTextField()
        setupPasswordTextFiled()
        setupSecureButton()
        //
        setupNotification()
        
        
    }
    
    private func changeLoginButtonEnabled(_ isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
        loginButton.alpha = isEnabled ? 1 : 0.5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

private extension LoginViewController {
    
    @IBAction func loginButtonDidTapped(_ sender: Any) {
        guard let email = mailAddressTextField.text,
              let password = passwordTextField.text else { return }
        indicator.show(.progress)
        UserUtil().login(email: email,
                         password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let title):
                self.indicator.flash(.error) {
                    self.showErrorAlert(title: title)
                }
            case .success:
                self.indicator.flash(.success) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func passwordForgotButtonDidTapped(_ sender: Any) {
        let passwordForgotVC = PasswordForgotViewController.instantiate()
        self.navigationController?.pushViewController(passwordForgotVC, animated: true)
    }
}



extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if isAllTextFieldInputted {
            changeLoginButtonEnabled(true)
        } else {
            changeLoginButtonEnabled(false)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

private extension LoginViewController {
    
    func setupLoginButton() {
        changeLoginButtonEnabled(false)
    }
    
    func setupMailAddressTextField() {
        mailAddressTextField.delegate = self
    }
    
    func setupPasswordTextFiled() {
        passwordTextField.delegate = self
        passwordTextField.rightView = secureButton
        passwordTextField.rightViewMode = .always
    }
    
    func setupSecureButton() {
        secureButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        secureButton.addTarget(self,
                               action: #selector(secureButtonDidTapped),
                               for: .touchUpInside)
    }
    
    @objc
    func secureButtonDidTapped() {
        if passwordTextField.isSecureTextEntry {
            secureButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            secureButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(keyboardWillShow), 
                                               name: UIResponder.keyboardWillShowNotification, 
                                               object: nil)
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(keyboardWillHide), 
                                               name: UIResponder.keyboardWillHideNotification, 
                                               object: nil)
    }
    
    @objc
    func keyboardWillShow(notification: Notification) {
        let loginButtonBottomY = loginButton.frame.maxY
        changeViewFrame(notification: notification, 
                        verificationPositionY: loginButtonBottomY)
    }
    
    @objc
    func keyboardWillHide() {
        returnOriginalViewFrame()
    }
    
}

