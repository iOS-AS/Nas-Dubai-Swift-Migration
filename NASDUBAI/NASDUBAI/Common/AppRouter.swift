//
//  AppRouter.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 29/12/23.
//

//import UIKit
//var appDelegate = UIApplication.shared.delegate as? AppDelegate
//@available(iOS 13.0, *)
//let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
//
//class AppRouter {
//    
//    class func landOnSutableVC() {
//        landingOnLoginVC()
//
//    }
//    
//    
//
//    
//    class func landingOnLoginVC() {
//        
//        guard let vc = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else  {
//            return
//        }
//        let rootVC = UINavigationController(rootViewController: vc)
//        if #available(iOS 13.0, *) {
//            sceneDelegate?.window?.rootViewController = rootVC
//        }
//        else {
//            appDelegate?.window?.rootViewController = rootVC
//        }
//    }
//    
//    
//    }
//    
