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
        
    }

    @IBAction private func loginButtonDidTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction private func passwordForgotButtonDidTapped(_ sender: Any) {
        let passwordForgotVC = PasswordForgotViewController.instantiate()
        self.navigationController?.pushViewController(passwordForgotVC, animated: true)
    }

}
