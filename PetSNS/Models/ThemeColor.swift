//
//  ThemeColor.swift
//  PetSNS
//
//  Created by 相良 詠斗 on 2021/09/10.
//

import UIKit

enum ThemeColor: CaseIterable {
    
    case white
    case gray
    case black
    
    case red
    case systemRed
    case yellowRed
    case yellow
    case yellowGreen
    case green
    case blueGreen
    case blue
    case systemBlue
    case bluePurple
    case purple
    case redPurple
    
    case redThin
    case yellowRedThin
    case yellowThin
    case yellowGreenThin
    case greenThin
    case blueGreenThin
    case blueThin
    case bluePurpleThin
    case purpleThin
    case redPurpleThin
    
    var color: UIColor {
        switch self {
            case .red:
                return UIColor.rgba(red: 255,
                                    green: 51,
                                    blue: 51)
            case .systemRed:
                return .systemRed
            case .redThin:
                return UIColor.rgba(red: 255,
                                    green: 179,
                                    blue: 179)
            case .yellowRed:
                return UIColor.rgba(red: 255,
                                    green: 153,
                                    blue: 51)
            case .yellowRedThin:
                return UIColor.rgba(red: 255,
                                    green: 217,
                                    blue: 179)
            case .yellow:
                return UIColor.rgba(red: 255,
                                    green: 255,
                                    blue: 77)
            case .yellowThin:
                return UIColor.rgba(red: 255,
                                    green: 255,
                                    blue: 179)
            case .yellowGreen:
                return UIColor.rgba(red: 153,
                                    green: 255,
                                    blue: 51)
            case .yellowGreenThin:
                return UIColor.rgba(red: 204,
                                    green: 255,
                                    blue: 153)
            case .green:
                return UIColor.rgba(red: 0,
                                    green: 255,
                                    blue: 0)
            case .greenThin:
                return UIColor.rgba(red: 128,
                                    green: 255,
                                    blue: 128)
            case .blueGreen:
                return UIColor.rgba(red: 51,
                                    green: 255,
                                    blue: 153)
            case .blueGreenThin:
                return UIColor.rgba(red: 153,
                                    green: 255,
                                    blue: 204)
            case .blue:
                return UIColor.rgba(red: 51,
                                    green: 51,
                                    blue: 255)
            case .blueThin:
                return UIColor.rgba(red: 179,
                                    green: 179,
                                    blue: 255)
            case .systemBlue:
                return .systemBlue
            case .bluePurple:
                return UIColor.rgba(red: 153,
                                    green: 51,
                                    blue: 255)
            case .bluePurpleThin:
                return UIColor.rgba(red: 217,
                                    green: 179,
                                    blue: 255)
            case .purple:
                return UIColor.rgba(red: 255,
                                    green: 51,
                                    blue: 255)
            case .purpleThin:
                return UIColor.rgba(red: 255,
                                    green: 153,
                                    blue: 255)
            case .redPurple:
                return UIColor.rgba(red: 153,
                                    green: 31,
                                    blue: 92)
            case .redPurpleThin:
                return UIColor.rgba(red: 255,
                                    green: 153,
                                    blue: 204)
            case .white:
                return UIColor.rgba(red: 240,
                                    green: 240,
                                    blue: 240)
            case .gray:
                return UIColor.rgba(red: 128,
                                    green: 128,
                                    blue: 128)
            case .black:
                return UIColor.rgba(red: 15,
                                    green: 15,
                                    blue: 15)
        }
    }
    
}

private extension UIColor {
    
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 100) -> UIColor {
        let rgb = [red, green, blue].map { value -> CGFloat in
            if value < 0 { return 0 }
            if value > 255 { return 1 }
            return value / 255
        }
        let alpha: CGFloat = {
            if alpha > 100 { return 1 }
            if alpha < 0 { return 0 }
            return CGFloat(alpha) / 100
        }()
        return self.init(red: rgb[0], green: rgb[1], blue: rgb[2], alpha: alpha)
    }
    
}
