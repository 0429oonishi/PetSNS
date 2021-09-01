//
//  PasswordForgotViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

// MARK: - ToDo Firebaseでメールテンプレートを書き換える

final class PasswordForgotViewController: UIViewController {
    
    @IBOutlet private weak var mailAddressTextField: UITextField!
    @IBOutlet private weak var sendButton: UIButton!
    
    private let indicator = Indicator(kinds: PKHUDIndicator())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeSendButtonEnabled(false)
        setupMailAddressTextField()
        
    }
    
    @IBAction private func sendButtonDidTapped(_ sender: Any) {
        guard let email = mailAddressTextField.text else { return }
        indicator.show(.progress)
        UserUtil().sendPasswordResetMail(email: email) { [weak self] result in
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
    
    private func setupMailAddressTextField() {
        mailAddressTextField.delegate = self
    }
    
    private func changeSendButtonEnabled(_ isEnabled: Bool) {
        sendButton.isEnabled = isEnabled
        sendButton.alpha = isEnabled ? 1 : 0.5
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension PasswordForgotViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let emailText = mailAddressTextField.text else { return }
        if emailText.isEmpty {
            changeSendButtonEnabled(false)
        } else {
            changeSendButtonEnabled(true)
        }
    }
    
}
