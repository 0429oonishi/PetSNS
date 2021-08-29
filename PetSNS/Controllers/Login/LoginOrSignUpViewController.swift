//
//  LoginOrSignUpViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class LoginOrSignUpViewController: UIViewController {

    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func loginButtonDidTapped(_ sender: Any) {
        let loginVC = LoginViewController.instantiate()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }

    @IBAction private func signUpButtonDidTapped(_ sender: Any) {
        let signUpVC = SignUpViewController.instantiate()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }

}
