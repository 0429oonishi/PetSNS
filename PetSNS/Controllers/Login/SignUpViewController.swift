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
    
    private let secureButton = UIButton()
    private let confirmationSecureButton = UIButton()
    private var isAllTextFieldInputted: Bool {
        guard let mailText = mailAddressTextField.text,
              let confirmationMailText = confirmationMailAddressTextField.text,
              let passwordText = passwordTextField.text,
              let confirmationPasswordText = confirmationPasswordTextField.text 
        else { return false }
        
        return !mailText.isEmpty 
            && !confirmationMailText.isEmpty 
            && !passwordText.isEmpty 
            && !confirmationPasswordText.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRegisterButton()
        setupMailAddressTextField()
        setupConfirmationMailAddressTextField()
        setupPasswordTextField()
        setupConfirmationPasswordTextField()
        SetupSecureButton()
        
    }
    
    //登録ボタンをタップした時の処理
    @IBAction private func registerButtonDidTapped(_ sender: Any) {
        if confirmInput(mail: mailAddressTextField.text!, 
                        confirmationMail: confirmationMailAddressTextField.text!, 
                        password: passwordTextField.text!, 
                        confirmationPassword: confirmationPasswordTextField.text!) {
            self.dismiss(animated: true, completion: nil)
        } else {
            return
        }
    }
    
    //登録ボタンの色と有効処理
    private func changeRegisterButton(_ isEnabled: Bool) {
        registerButton.isEnabled = isEnabled
        registerButton.alpha = isEnabled ? 1 : 0.5
    }
    
    //viewをタップした際キーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //チェック作業
    func confirmInput(mail: String, 
                      confirmationMail: String, 
                      password: String, 
                      confirmationPassword: String) -> Bool {
        
        var checkers = [localValidation]()
        checkers.append(contentsOf: [mailAddressFormatChecker(mail: mail), 
                                     numberOfPasswordCharactersChecker(password: password), 
                                     passwordCharacterFormatChecker(password: password), 
                                     matchConfirmationMailChecker(mail: mail, confirmationMail: confirmationMail), 
                                     matchConfirmationPasswordChecker(password: password, confirmationPassword: confirmationPassword)])
        if checkers.filter({ $0 != .succucess }).isEmpty {
            return true
        } else {
            let message = checkers.filter({ $0 != .succucess }).map { $0.warningMessage() }.joined(separator: "\n")
            self.showErrorAlert(title: "確認", message: "\(message)")
            return false
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    //全てのtextfieldが入力された場合登録ボタンを押せるようにする
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if isAllTextFieldInputted {
            changeRegisterButton(true)
        } else {
            changeRegisterButton(false)
        }
    }
    
    //returnを押した時キーボードを閉じている
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - 各種セットアップ
private extension SignUpViewController {
    
    //登録ボタンのセットアップ
    func setupRegisterButton() {
        changeRegisterButton(false)
    }
    
    //メール入力欄のセットアップ
    func setupMailAddressTextField() {
        mailAddressTextField.delegate = self
    }
    
    //メール確認欄のセットアップ
    func setupConfirmationMailAddressTextField() {
        confirmationMailAddressTextField.delegate = self
    }
    
    //パスワード入力欄のセットアップ
    func setupPasswordTextField() {
        passwordTextField.delegate = self
        passwordTextField.rightView = secureButton
        passwordTextField.rightViewMode = .always
    }
    
    //パスワード確認欄のセットアップ
    func setupConfirmationPasswordTextField() {
        confirmationPasswordTextField.delegate = self
        confirmationPasswordTextField.rightView = confirmationSecureButton
        confirmationPasswordTextField.rightViewMode = .always
    }
    
    //目隠しボタンのセットアップ
    func SetupSecureButton() {
        secureButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        secureButton.addTarget(self, 
                               action: #selector(secureButtonDidTapped), 
                               for: .touchUpInside)
        confirmationSecureButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        confirmationSecureButton.addTarget(self, 
                                           action: #selector(cunfirmationSecureButtonDidTapped), 
                                           for: .touchUpInside)
    }
    
    //目隠しボタンタップ時の処理
    @objc
    func secureButtonDidTapped() {
        if passwordTextField.isSecureTextEntry {
            secureButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            secureButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    //確認用の目隠しボタンタップ時の処理
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

// MARK: - バリデーション
private extension SignUpViewController {
    
    //メールアドレスの形式チェック
    func mailAddressFormatChecker(mail: String) -> localValidation {
        let mailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        if NSPredicate(format: "SELF MATCHES %@", mailRegex).evaluate(with: mail) {
            return .succucess
        } else {
            return .mailAddressFormatError
        }
    }
    
    //パスワードの文字数チェック
    func numberOfPasswordCharactersChecker(password: String) -> localValidation {
        if 6 <= password.count && password.count <= 12 {
            return .succucess
        } else {
            return .numberOfPasswordCharactersError
        }
    }
    
    //パスワードの形式チェック
    func passwordCharacterFormatChecker(password: String) -> localValidation {
        if NSPredicate(format: "SELF MATCHES %@", "[a-zA-Z0-9]+").evaluate(with: password) {
            return .succucess
        } else {
            return .passwordCharacterFormatError
        }
    }
    
    //確認用メールアドレスと一致してるか
    func matchConfirmationMailChecker(mail: String, confirmationMail: String) -> localValidation {
        if mail == confirmationMail {
            return .succucess
        } else {
            return .notMatchConfirmationMail
        }
    }
    
    //確認用パスワードと一致してるか
    func matchConfirmationPasswordChecker(password: String, confirmationPassword: String) -> localValidation {
        if password == confirmationPassword {
            return .succucess
        } else {
            return .notMatchConfirmationPassword
        }
    }
}

private enum localValidation {
    case succucess
    case mailAddressFormatError
    case numberOfPasswordCharactersError
    case passwordCharacterFormatError
    case notMatchConfirmationMail
    case notMatchConfirmationPassword
    
    func warningMessage() -> String {
        switch self {
        case .succucess:
            return "成功"
        case .mailAddressFormatError:
            return "メールアドレスの形式が正しくありません"
        case .numberOfPasswordCharactersError:
            return "パスワードは6文字以上12文字未満で入力してください"
        case .passwordCharacterFormatError:
            return "パスワードは半角英数字のみ使えます"
        case .notMatchConfirmationMail:
            return "確認用メールアドレスと一致しません"
        case .notMatchConfirmationPassword:
            return "確認用パスワードと一致しません"
        }
    }
}
