//
//  CGFloatExtension.swift
//  NAS
//
//  Created by Naveeth Parvege on 19/05/21.
//

import UIKit

extension CGFloat {
    
    static func getFontSize(fontSize: CGFloat) -> CGFloat {
        
        var newFontSize: CGFloat = 0.0
        
        if let screenType = UIDevice().screenType {
            
            switch screenType {
            case .iPhone4:
                newFontSize = ( fontSize / FontSizeRatio.iPhone4 ) * SCREEN_WIDTH
                
            case .iPhone5:
                newFontSize = (fontSize / FontSizeRatio.iPhone5) * SCREEN_WIDTH
                
            case .iPhone6:
                newFontSize = (fontSize / FontSizeRatio.iPhone6) * SCREEN_WIDTH
                
            case .iPhone6Plus:
                newFontSize = (fontSize / FontSizeRatio.iPhone6Plus) * SCREEN_WIDTH
                
            case .iPhoneX:
                newFontSize = (fontSize / FontSizeRatio.iPhoneX) * SCREEN_WIDTH
                
            case .iPhoneXr:
                newFontSize = (fontSize / FontSizeRatio.iPhoneXr) * SCREEN_WIDTH
                
            case .iPhoneXsMax:
                newFontSize = (fontSize / FontSizeRatio.iPhoneXsMax) * SCREEN_WIDTH
                
            case .iPadAir:
                newFontSize = (fontSize / FontSizeRatio.iPadAir) * iPAD_FONT_RATIO
                
            case .iPadPro:
                newFontSize = (fontSize / FontSizeRatio.iPadPro) * iPAD_FONT_RATIO
                
            default:
                break
                
            }
        }
        
        return newFontSize
    }
}
struct FontSizeRatio {
    static let iPhone4: CGFloat = 100
    static let iPhone5: CGFloat = 100
    static let iPhone6: CGFloat = 100
    static let iPhone6Plus: CGFloat = 110
    static let iPhoneX: CGFloat = 100
    static let iPhoneXr: CGFloat = 100
    static let iPhoneXsMax: CGFloat = 100
    static let iPadAir: CGFloat = 100
    static let iPadPro: CGFloat = 100
}
