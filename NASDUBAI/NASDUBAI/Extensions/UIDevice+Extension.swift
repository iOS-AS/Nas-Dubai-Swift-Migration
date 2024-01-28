//
//  UIDeviceExtension.swift
//  NAS
//
//  Created by Mobatia MacMini 2 on 18/03/21.
//

import UIKit

extension UIDevice {
    
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    var typeOfDevice: DeviceType {

        if UIDevice().userInterfaceIdiom == .phone {
            return .iPhone
        } else {
            return .iPad
        }
    }
    
    enum DeviceType {
        case iPhone, iPad
    }
    
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus    // "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus". 12 Mini are same(0.1 is lesser than plus series)
        case iPhoneX    //X and XS are Same
        case iPhoneXr   //XR, 12, 12 pro are same
        case iPhoneXsMax    //Only XSMax. 12 Pro max is 0.2 more than XS Max. So we use XS Max Hight.
        case iPadAir
        case iPadPro
        case Unknown
    }
    
    var screenType: ScreenType? {
        guard iPhone else { return nil }
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 2208:
            return .iPhone6Plus
        case 2436:
            return .iPhoneX
        case 1792:
            return .iPhoneXr
        case 2688:
            return .iPhoneXsMax
        default:
            return getDeviceType()
        }
    }
    
    func getDeviceType() -> ScreenType {
        
        let deviceName = getDeviceName()

        if ["iPhone 4", "iPhone 4s"].contains(deviceName) {
            return .iPhone4
        } else if ["iPhone 5", "iPhone 5c", "iPhone 5s", "iPhone SE"].contains(deviceName) {
            return .iPhone5
        } else if ["iPhone 6", "iPhone 7", "iPhone 6s", "iPhone 8", "iPhone SE (2nd generation)"].contains(deviceName) {
            return .iPhone6
        } else if ["iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone 12 mini", "iPhone 13 mini"].contains(deviceName) {
            return .iPhone6Plus
        } else if ["iPhone X", "iPhone XS", "iPhone 11 Pro"].contains(deviceName) {
            return .iPhoneX
        } else if ["iPhone XR", "iPhone 11", "iPhone 12", "iPhone 12 Pro", "iPhone 13", "iPhone 13 Pro"].contains(deviceName) {
            return .iPhoneXr
        } else if ["iPhone XS Max", "iPhone 11 Pro Max", "iPhone 12 Pro Max", "iPhone 13 Pro Max"].contains(deviceName) {
            return .iPhoneXsMax
        } else if ["iPad Air (4th generation)", "iPad Pro (11-inch) (1st generation)", "iPad Pro (11-inch) (2nd generation)"].contains(deviceName) {
            return .iPadAir
        } else if ["iPad Pro (12.9-inch) (3rd generation)", "iPad Pro (12.9-inch) (4th generation)", "iPad Pro (12.9-inch) (5th generation)"].contains(deviceName) {
            return .iPadPro
        }
        else {

            switch typeOfDevice {
            case .iPhone:
                return .iPhoneXsMax
            case .iPad:
                return .iPadAir
            }
//            return .Unknown
        }
    }
    
    func getDeviceName() -> String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {

        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPhone12,1":                              return "iPhone 11"
        case "iPhone12,3":                              return "iPhone 11 Pro"
        case "iPhone12,5":                              return "iPhone 11 Pro Max"
        case "iPhone12,8":                              return "iPhone SE (2nd generation)"
        case "iPhone13,1":                              return "iPhone 12 mini"
        case "iPhone13,2":                              return "iPhone 12"
        case "iPhone13,3":                              return "iPhone 12 Pro"
        case "iPhone13,4":                              return "iPhone 12 Pro Max"

        default:                                        return identifier
        }
    }
    
    // helper funcs
    static func isScreen35inch() -> Bool {
        return UIDevice().screenType == .iPhone4
    }
    
    static func isScreen4inch() -> Bool {
        return UIDevice().screenType == .iPhone5
    }
    
    static func isScreen47inch() -> Bool {
        return UIDevice().screenType == .iPhone6
    }
    
    static func isScreen55inch() -> Bool {
        return UIDevice().screenType == .iPhone6Plus
    }
    
    static func isScreen57inch() -> Bool {
        return UIDevice().screenType == .iPhoneX
    }
    
    static func isScreen61inch() -> Bool {
        return UIDevice().screenType == .iPhoneXr
    }
    
    static func isScreen65inch() -> Bool {
        return UIDevice().screenType == .iPhoneXsMax
    }
    
    static func isScreenLessThan47inch() -> Bool {
        return UIDevice().screenType == .iPhone4 || UIDevice().screenType == .iPhone5
    }

    static func getCustomKeyboardHeight() -> CGFloat? {
        if let type: ScreenType = UIDevice().screenType {
            switch type {
            case .iPhone4:
                return 216
            case .iPhone5:
                return 216
            case .iPhone6:
                return 216
            case .iPhone6Plus:
                return 226
            case .iPhoneX, .iPhoneXr, .iPhoneXsMax:
                return 267
            default:
                return 226
            }
        } else {
            return 226
        }
    }
    
    static func safeAreaBottomInset() -> CGFloat {
       /*
        if #available(iOS 11.0, *) {
            
            if let insetHeight = sceneDelegate?.window?.safeAreaInsets {
                return insetHeight.bottom
            } else {
                return 0
            }
            
        } else {
            return 0
        }
        */
        return 0
    }
    
    static func is32BitDevice() -> Bool {
        if MemoryLayout<Int>.size == 4 {
            return true
        } else {
            return false
        }
    }
    
}


struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
}

