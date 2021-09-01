//
//  UIAlertController+Extension.swift
//  PetSNS
//
//  Created by 坂本龍哉 on 2021/09/01.
//

import UIKit

extension UIAlertController {
    
    static func makeAuthAlert(title: String, message: String? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
        return alert
    }
    
}
