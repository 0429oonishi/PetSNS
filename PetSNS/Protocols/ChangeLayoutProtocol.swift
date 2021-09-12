//
//  ChangeLayoutProtocol.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/09/12.
//

import UIKit

protocol ChangeLayoutProtocol: AnyObject {
    func changeLayout(constraints: [NSLayoutConstraint?],
                      verticalSpace: CGFloat,
                      withDuration: TimeInterval)
    func changeStackViewSpacing(stackViews: [UIStackView?],
                                spacing: CGFloat,
                                withDuration: TimeInterval)
}

extension ChangeLayoutProtocol where Self: UIViewController {
    
    func changeLayout(constraints: [NSLayoutConstraint?],
                      verticalSpace: CGFloat,
                      withDuration: TimeInterval = 1.0) {
        constraints
            .compactMap { $0 }
            .forEach { $0.constant = verticalSpace }
        UIView.animate(withDuration: withDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func changeStackViewSpacing(stackViews: [UIStackView?],
                                spacing: CGFloat,
                                withDuration: TimeInterval = 1.0) {
        stackViews
            .compactMap { $0 }
            .forEach { $0.spacing = spacing }
        UIView.animate(withDuration: withDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
}
