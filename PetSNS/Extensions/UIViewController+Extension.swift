//
//  UIViewController+Extension.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/29.
//

import UIKit

extension UIViewController {
    
    static func instantiate() -> Self {
        var storyboardName = String(describing: self)
        if let result = storyboardName.range(of: "ViewController") {
            storyboardName.removeSubrange(result)
        } else {
            fatalError("Storyboardの名前が正しくない")
        }
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(
            identifier: String(describing: self)
        ) as! Self
        return vc
    }
    
}

extension UIViewController {
    
    func showErrorAlert(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension UIViewController {
    
    enum DeviceType {
        case large
        case small
        
        var verticalLayoutSpace: CGFloat {
            switch self {
            case .large: return 30
            case .small: return 5
            }
        }
        var verticalStackViewSpace: CGFloat {
            switch self {
            case .large: return 20
            case .small: return 5
            }
        }
        var defaultVerticalLayoutSpace: CGFloat {
            switch self {
            case .large: return 50
            case .small: return 50
            }
        }
        var defaultVerticalStackViewSpace: CGFloat {
            switch self {
            case .large: return 20
            case .small: return 20
            }
        }
        
        mutating func getDeviceType() {
            // 12ProMax height 926.0
            // SE2nd    height 667.0
            let currentDeviceHeight = UIScreen.main.bounds.size.height
            let averageHeight: CGFloat = (926.0 + 667.0) / 2
            if currentDeviceHeight > averageHeight {
                self = .large
            } else {
                self = .small
            }
        }
    }
    
}
