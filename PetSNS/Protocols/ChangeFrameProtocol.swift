//
//  ChangeLayoutProtocol.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/09/12.
//

import UIKit

protocol ChangeFrameProtocol: AnyObject {
    func changeViewFrame(notification: Notification,
                         verificationPositionY: CGFloat,
                         withDuration: TimeInterval)
    func returnOriginalViewFrame()
}

extension ChangeFrameProtocol where Self: UIViewController {
    
    func changeViewFrame(notification: Notification,
                         verificationPositionY: CGFloat,
                         withDuration: TimeInterval = 0.25) {
        if self.view.frame != CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height) { returnOriginalViewFrame() }
        
        guard let keyboardPositionY = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                       as? NSValue)?.cgRectValue.minY else { return }
        let transformY = keyboardPositionY - verificationPositionY
        if keyboardPositionY < verificationPositionY {
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
