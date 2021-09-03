//
//  SignUpValidation.swift
//  PetSNS
//
//  Created by 相良 詠斗 on 2021/09/03.
//

import Foundation

enum LocalValidation {
    case succucess, 
         mailAddressFormatError, 
         numberOfPasswordCharactersError, 
         passwordCharacterFormatError, 
         notMatchConfirmationMail, 
         notMatchConfirmationPassword
    
    var ErrorMessage: String {
        switch self {
        case .succucess: return "成功"
        case .mailAddressFormatError: return "メールアドレスの形式が正しくありません"
        case .numberOfPasswordCharactersError: return "パスワードは6文字以上12文字未満で入力してください"
        case .passwordCharacterFormatError: return "パスワードは半角英数字のみ使えます"
        case .notMatchConfirmationMail: return "確認用メールアドレスと一致しません"
        case .notMatchConfirmationPassword: return "確認用パスワードと一致しません"
        }
    }
}

final class LocalValidationCheckers {
    func textIsEmptyChecker(target: [String]) -> Bool {
        return target.allSatisfy{ !$0.isEmpty }
    }
    
    func mailAddressFormatChecker(mail: String) -> LocalValidation {
        let mailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let checkMailFormat = NSPredicate(format: "SELF MATCHES %@", mailRegex).evaluate(with: mail)
        return checkMailFormat ? .succucess : .mailAddressFormatError
    }
    
    func numberOfPasswordCharactersChecker(password: String) -> LocalValidation {
        if 6 <= password.count && password.count <= 12 {
            return .succucess
        } else {
            return .numberOfPasswordCharactersError
        }
    }
    
    func passwordCharacterFormatChecker(password: String) -> LocalValidation {
        let checkPasswordFormat = NSPredicate(format: "SELF MATCHES %@", "[a-zA-Z0-9]+").evaluate(with: password)
        return checkPasswordFormat ? .succucess : .passwordCharacterFormatError
    }
    
    func matchConfirmationChecker(target: String, confirmation: String) -> LocalValidation {
        if target == confirmation {
            return .succucess
        } else {
            return .notMatchConfirmationMail
        }
    }
}
