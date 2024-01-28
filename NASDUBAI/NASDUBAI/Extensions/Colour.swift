//
//  Colour.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 22/01/24.
//

import Foundation
import UIKit

extension UIColor {

    //MARK:- Color
    static func bgColor() -> UIColor {
        return .white
    }

    //rgba(r77,g196,b207,a255)
    static func appThemeColor() -> UIColor {
        return UIColor(red: 65.0/255.0, green: 183.0/255.0, blue: 196.0/255.0, alpha: 1.0)
    }
    
    static func ptaCellColour() -> UIColor {
        return UIColor(red: 41.0/255.0, green: 41.0/255.0, blue: 41.0/255.0, alpha: 1.0)
    }
    
    static func secondaryColor() -> UIColor {
        return UIColor(red: 0.0/255.0, green: 45.0/255.0, blue: 74.0/255.0, alpha: 1.0)
    }
    

    static func externalTileColor() -> UIColor {
        return UIColor(red: 31/255.0, green: 56/255.0, blue: 88/255.0, alpha: 1.0)
    }
    static func ccalTileColor() -> UIColor {
        return UIColor(red: 230/255.0, green: 138/255.0, blue: 84/255.0, alpha: 1.0)
    }
    
//    static func secondaryColor() -> UIColor {
//        return UIColor(red: 0.0/255.0, green: 45.0/255.0, blue: 74.0/255.0, alpha: 1.0)
//    }

    static func pageTitleColor() -> UIColor {
        return .black
    }

    static func errorColor() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 38.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }

    static func titleColor() -> UIColor {
        return .red
    }

    static func buttonTitleColor() -> UIColor {
        return .white
    }

    static func descriptionColor() -> UIColor {
        return .red
    }

    static func placeholderColor() -> UIColor {
        return UIColor.darkGray.withAlphaComponent(0.6)
    }

    static func badgeColor() -> UIColor {
        return UIColor.red
    }

    //rgba(70,154,233,255)
    static func twitterColor() -> UIColor {
        return UIColor(red: 70.0/255.0, green: 154.0/255.0, blue: 233.0/255.0, alpha: 1.0)
    }

    //rgba(187,16,138,255)
    static func instagramColor() -> UIColor {
        return UIColor(red: 187.0/255.0, green: 16.0/255.0, blue: 138.0/255.0, alpha: 1.0)
    }
    
    static func groupedColor() -> UIColor {
        return UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 247.0/255.0, alpha: 1.0)
    }
    
    static func groupedYellow() -> UIColor {
        return #colorLiteral(red: 1, green: 0.6987019181, blue: 0.05847611278, alpha: 1)
    }

    static func foodCategoryColor() -> UIColor { //#ff771c // rgba(255,119,28,255)
        return UIColor(red: 255.0/255.0, green: 119.0/255.0, blue: 28.0/255.0, alpha: 1.0)
    }
    
    //rgba(45,68,134,255) facebook
    static func facebookColor() -> UIColor {
        return UIColor(red: 45.0/255.0, green: 68.0/255.0, blue: 134.0/255.0, alpha: 1.0)
    }

    static func fromHexCode(hex:String) -> UIColor {

        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
