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
    
    @IBOutlet private weak var signUpLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var mailAddressTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var passwordTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var registerButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var mailStackView: UIStackView!
    @IBOutlet private weak var passwordStackView: UIStackView!
    
    private let indicator = Indicator(kinds: PKHUDIndicator())
    private let signUpValidation = LocalValidationChecker()
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
        setupNotification()
        
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
            self.showErrorAlert(title: "確認", message: alertMessage)
        } else {
            indicator.show(.progress)
            UserUtil().signUp(email: mail, 
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
                        signUpValidation.matchConfirmationMailChecker(target: mail, confirmation: confirmationMail),
                        signUpValidation.matchConfirmationPasswordChecker(target: password, confirmation: confirmationPassword)]
        
        if checkers.filter({ $0 != .succucess }).isEmpty {
            return nil
        } else {
            let message = checkers.filter({ $0 != .succucess }).map { $0.ErrorMessage }.joined(separator: "\n")
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
    
    private func setupNotification() {
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
    private func keyboardWillShow(notification: Notification) {
        changeLayout(verticalSpace: 5, withDuration: 1.0)
        changeStackViewSpacing(spacing: 5, withDuration: 1.0)
    }
    
    @objc
    private func keyboardWillHide(notification: Notification) {
        changeLayout(verticalSpace: 50, withDuration: 1.0)
        changeStackViewSpacing(spacing: 20, withDuration: 1.0)
    }
    
    private func changeLayout(verticalSpace: CGFloat, withDuration: TimeInterval) {
        [signUpLabelTopConstraint,
         mailAddressTopConstraint,
         passwordTopConstraint,
         registerButtonTopConstraint].forEach { $0?.constant = verticalSpace }
        
        UIView.animate(withDuration: withDuration,
                       animations: { [weak self] in
                        guard let self = self else { return }
                        self.view.layoutIfNeeded()
                       }, completion: nil)

    }
    
    private func changeStackViewSpacing(spacing: CGFloat, withDuration: TimeInterval) {
        [mailStackView,
         passwordStackView].forEach { $0?.spacing = spacing }
        
        UIView.animate(withDuration: withDuration,
                       animations: { [weak self] in
                        guard let self = self else { return }
                        self.view.layoutIfNeeded()
                       }, completion: nil)
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
