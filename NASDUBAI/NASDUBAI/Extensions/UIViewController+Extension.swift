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
        
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
        self.navigationController?.pushViewController(vc!, animated: true)
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
    
    func showSignUp() {
        
//        let vc = UIStoryboard.init(name: "SignUpStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
//        self.navigationController?.pushViewController(vc!, animated: false)
        
        let storyboardMain = UIStoryboard(name: "SignUpStoryboard", bundle: nil)
        let vc = storyboardMain.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
//
    func showForgetPassword() {
        let storyboardMain = UIStoryboard(name: "ForgotPasswordVC", bundle: nil)
        let vc = storyboardMain.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
}
