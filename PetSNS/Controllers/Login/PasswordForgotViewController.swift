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
    
    private func showErrorAlert(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
