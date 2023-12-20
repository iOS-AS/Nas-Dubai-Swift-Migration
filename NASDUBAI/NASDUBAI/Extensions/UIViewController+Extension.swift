//
//  UIViewController+Extension.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 07/11/23.
//

import UIKit

var alertMessage: Observable<String> = Observable("")
extension UIViewController {
    
    
    func pushToVC(name:String)
    {
        
    }
    
    @objc func pushToHome() {
        let mainVC = UIStoryboard.init(name: "DummyClickStoryBoard", bundle: nil)
        let rootVC = mainVC.instantiateViewController(withIdentifier: "DummyViewController")
    }
    
    func presentSingleBtnAlert<T: UIViewController>(_ parent: T? = nil, message: String) {
       // let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "SingleBtnAlertViewController") as! SingleBtnAlertViewController
//        vc.message = message
//        vc.delegate = parent as? SingleBtnAlertDelegate
//        vc.modalPresentationStyle = .overCurrentContext
//        presentViewControllerFromVisibleViewController(vc, animated: false, completion: nil)

    }
    
    func showAlerts() {
        alertMessage.bind { [self] (message) in
            if message == "" { return }
            alertMessage.value = ""
            presentSingleBtnAlert(message: message)
        }
    }
    
//    func presentSignUp() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
//        vc.modalPresentationStyle = .overCurrentContext
//        present(vc, animated: false)
//    }
//
//    func presentForgotPWVC() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "ForgotPWViewController") as! ForgotPWViewController
//        vc.modalPresentationStyle = .overCurrentContext
//        present(vc, animated: false)
//    }
    
}
