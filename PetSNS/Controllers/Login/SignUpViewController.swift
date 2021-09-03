//
//  SignUpViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    @IBOutlet private weak var mailAddressTextField: UITextField!
    @IBOutlet private weak var confirmationMailAddressTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmationPasswordTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    
    private let signUpValidation = SignUpValidation()
    private let secureButton = UIButton()
    private let confirmationSecureButton = UIButton()
    private var isAllTextFieldInputted: Bool {
        guard let mailText = mailAddressTextField.text,
              let confirmationMailText = confirmationMailAddressTextField.text,
              let passwordText = passwordTextField.text,
              let confirmationPasswordText = confirmationPasswordTextField.text 
        else { return false }
        
        return signUpValidation.textIsEmptyChecker(target: [mailText, 
                                                            confirmationMailText, 
                                                            passwordText, 
                                                            confirmationPasswordText])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpRegisterButton()
        setUpMailAddressTextField()
        setUpConfirmationMailAddressTextField()
        setUpPasswordTextField()
        setUpConfirmationPasswordTextField()
        setUpSecureButton()
        
    }
    
    @IBAction private func registerButtonDidTapped(_ sender: Any) {
        guard let mail = mailAddressTextField.text, 
              let confirmationMail = confirmationMailAddressTextField.text, 
              let password = passwordTextField.text, 
              let confirmationPassword = confirmationPasswordTextField.text 
        else { return }
        
        if let alertMessage = confirmInput(mail: mail, 
                                           confirmationMail: confirmationMail, 
                                           password: password, 
                                           confirmationPassword: confirmationPassword) {
            self.showErrorAlert(title: "確認", message: "\(alertMessage)")
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func changeRegisterButton(_ isEnabled: Bool) {
        registerButton.isEnabled = isEnabled
        registerButton.alpha = isEnabled ? 1 : 0.5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func confirmInput(mail: String, 
                      confirmationMail: String, 
                      password: String, 
                      confirmationPassword: String) -> String? {
        
        let checkers = [signUpValidation.mailAddressFormatChecker(mail: mail),
                        signUpValidation.numberOfPasswordCharactersChecker(password: password),
                        signUpValidation.passwordCharacterFormatChecker(password: password),
                        signUpValidation.matchConfirmationChecker(target: mail, confirmation: confirmationMail),
                        signUpValidation.matchConfirmationChecker(target: password, confirmation: confirmationPassword)]
        
        if checkers.filter({ $0 != .succucess }).isEmpty {
            return nil
        } else {
            let message = checkers.filter({ $0 != .succucess }).map { $0.message }.joined(separator: "\n")
            return message
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if isAllTextFieldInputted {
            changeRegisterButton(true)
        } else {
            changeRegisterButton(false)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

private extension SignUpViewController {
    
    func setUpRegisterButton() {
        changeRegisterButton(false)
    }
    
    func setUpMailAddressTextField() {
        mailAddressTextField.delegate = self
    }
    
    func setUpConfirmationMailAddressTextField() {
        confirmationMailAddressTextField.delegate = self
    }
    
    func setUpPasswordTextField() {
        passwordTextField.delegate = self
        passwordTextField.rightView = secureButton
        passwordTextField.rightViewMode = .always
    }
    
    func setUpConfirmationPasswordTextField() {
        confirmationPasswordTextField.delegate = self
        confirmationPasswordTextField.rightView = confirmationSecureButton
        confirmationPasswordTextField.rightViewMode = .always
    }
    
    func setUpSecureButton() {
        secureButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        secureButton.addTarget(self, 
                               action: #selector(secureButtonDidTapped), 
                               for: .touchUpInside)
        confirmationSecureButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        confirmationSecureButton.addTarget(self, 
                                           action: #selector(cunfirmationSecureButtonDidTapped), 
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
    
    @objc
    func cunfirmationSecureButtonDidTapped() {
        if confirmationPasswordTextField.isSecureTextEntry {
            confirmationSecureButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            confirmationSecureButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
        confirmationPasswordTextField.isSecureTextEntry.toggle()
    }
}
