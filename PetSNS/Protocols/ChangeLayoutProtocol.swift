//
//  ChangeLayoutProtocol.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/09/12.
//

import UIKit

protocol ChangeLayoutProtocol: AnyObject {
    func changeViewFrame(keyboardPositionY: CGFloat,
                   hidingPositionY: CGFloat,
                   withDuration: TimeInterval)
    func returnOriginalViewFrame()
}

extension ChangeLayoutProtocol where Self: UIViewController {
    
    func changeViewFrame(keyboardPositionY: CGFloat,
                   hidingPositionY: CGFloat,
                   withDuration: TimeInterval = 0.25) {
        let transformY = keyboardPositionY - hidingPositionY
        if keyboardPositionY < hidingPositionY {
            UIView.animate(withDuration: withDuration) {
                self.view.frame = CGRect(x: 0,
                                         y: self.view.frame.origin.y + transformY,
                                         width: self.view.bounds.width,
                                         height: self.view.bounds.height)
            }
        } else {
            self.returnOriginalViewFrame()
        }
    }

    func returnOriginalViewFrame() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.frame = CGRect(x: 0,
                                     y: 0,
                                     width: self.view.bounds.width,
                                     height: self.view.bounds.height)
        }, completion: nil)
    }
}
