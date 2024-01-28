//
//  AppVariable.swift
//  BSKL
//
//  Created by Naveeth's on 22/04/21.
//

import UIKit

let SCREEN_HEIGHT = UIScreen.main.bounds.height
let iPAD_FONT_RATIO = SCREEN_WIDTH * 0.75
let DEVICE_TYPE = "1"



enum FontType {

    case Regular
    case Bold
    case Semibold
    case Light
    case ExtraLight
    case Large
}

final class AppVariable: NSObject {
    
    static let shared = AppVariable()
    private let numberFormatter = NumberFormatter()
    
    
    override init() {
        super.init()
        
    }
    
    //MARK:- Font
    func appRegularFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "SourceSansPro-Regular", size: size)!
    }
    
    func appBoldFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "SourceSansPro-Bold", size: size)!
    }
    
    func appSemiboldFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "SourceSansPro-Semibold", size: size)!
    }
    
    func appLightFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "SourceSansPro-Light", size: size)!
    }
    
    func appExtraLightFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "SourceSansPro-ExtraLight", size: size)!
    }
    
    func appLargeFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "DJ5CTRIAL_Large", size: size)!
    }
    
    func appFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "DJ5CTRIAL", size: size)!
    }
    
    func appFontWithSize(type: FontType, size: CGFloat) -> UIFont {
        
        let fontSize = CGFloat.getFontSize(fontSize: size)
        
        if type == .Regular {
            return appRegularFontWithSize(size: fontSize)
        }
        else if type == .Bold {
            return appBoldFontWithSize(size: fontSize)
        }
        else if type == .Semibold {
            return appSemiboldFontWithSize(size: fontSize)
        }
        else if type == .Light {
            return appLightFontWithSize(size: fontSize)
        }
        else if type == .ExtraLight {
            return appExtraLightFontWithSize(size: fontSize)
        }
        else if type == .Large {
            return appLargeFontWithSize(size: fontSize)
        }
        
        return UIFont()
    }
    
    //MARK:- App Details
    lazy var appName: String? = {
        guard let dictionary = Bundle.main.infoDictionary else { return "" }
        let version = dictionary["CFBundleName"] as? String
        return version
    }()
    
    lazy var appVersion : String? = {
        guard let dictionary = Bundle.main.infoDictionary else { return "" }
        let version = dictionary["CFBundleShortVersionString"] as? String
        return version
    }()
    
    lazy var build : String? = {
        guard let dictionary = Bundle.main.infoDictionary else { return "" }
        let version = dictionary["CFBundleVersion"] as? String
        return version
    }()
    
    lazy var bundleID : String? = {
        guard let dictionary = Bundle.main.infoDictionary else { return "" }
        let version = dictionary["CFBundleIdentifier"] as? String
        return version
    }()
    
    var deviceOSVersion: String? {
        return UIDevice.current.systemVersion
    }
    
    //MARK:- UserDefaults
    func getValueFromUserDefault(key k : String) -> Any? {
        return UserDefaults.standard.value(forKey: k)
    }
}
