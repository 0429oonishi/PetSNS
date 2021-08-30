//
//  UserUtil.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/30.
//
//

import UIKit
import Firebase

final class UserUtil {

    func createAccount(email:String, password:String) {
        Auth.auth().createUser(withEmail: email, password: password) { AuthResultCallback, error in
            guard let user = AuthResultCallback?.user, error == nil else {
                print("登録に失敗しました")
                print("エラー詳細：\(error!)")
                return
            }
            print("\(user.email!)で登録完了しました")
        }
    }

    func logIn(mail: String, password: String){
        Auth.auth().signIn(withEmail: mail, password: password){ AuthResultCallback, error in
            guard let user = AuthResultCallback?.user, error == nil else {
                print("ログインに失敗しました")
                print("エラー詳細：\(error!)")
                return
            }
            print("\(user.email!)にログイン完了しました")
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("ログアウトに失敗しました\(error)")
            return
        }
        print("ログアウトに成功しました")
    }

    func checkCurrentUser() {
        if let currentuser = Auth.auth().currentUser {
            print("現在\(currentuser.email!)でログインしてます")
        } else {
            print("現在ログアウト中です")
        }
    }

}
