//
//  DeviceType.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/09/12.
//

import UIKit

struct DeveiceType {
    let deviceType: DeviceType
}

enum DeviceType {
    case large
    case small
}

extension DeviceType {
    
    var verticalLayoutSpace: CGFloat {
        switch self {
        case .large: return 30
        case .small: return 5
        }
    }
    var defaultVerticalLayoutSpace: CGFloat {
        switch self {
        case .large: return 50
        case .small: return 50
        }
    }
    var verticalStackViewSpace: CGFloat {
        switch self {
        case .large: return 20
        case .small: return 5
        }
    }
    var defaultVerticalStackViewSpace: CGFloat {
        switch self {
        case .large: return 20
        case .small: return 20
        }
    }

}

protocol DeviceTypeProtocol {
    func getDeviceType() -> DeviceType
}

extension DeviceTypeProtocol where Self: UIViewController {
    
    func getDeviceType() -> DeviceType {
        // 12ProMax height 926.0
        // SE2nd    height 667.0
        let currentDeviceHeight = UIScreen.main.bounds.size.height
        let averageHeight: CGFloat = (926.0 + 667.0) / 2
        if currentDeviceHeight > averageHeight {
            return .large
        } else {
            return .small
        }
    }

}
