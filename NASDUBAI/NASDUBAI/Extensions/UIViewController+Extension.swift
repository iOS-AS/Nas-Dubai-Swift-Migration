//
//  UIViewController+Extension.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 07/11/23.
//

import UIKit

var alertMessage: Observable<String> = Observable("")
extension UIViewController {
    
    func addRevealToSelf<T: UIViewController>(_ parent: T? = nil) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller:RevealVC = mainStoryBoard.instantiateViewController(withIdentifier: "RevealVC") as! RevealVC
        controller.delegate = parent as? RevealDelegate
        let width = UIScreen.main.bounds.width
        print("widthValue: \(width)")
        controller.view.frame = CGRect(x: -width, y: 0, width: width, height: view.frame.height)
        self.view.addSubview(controller.view)
        self.addChild(controller)
        controller.didMove(toParent: self)

//        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(showReveal))
//        gesture.direction = .right
//        self.view.addGestureRecognizer(gesture)

        // Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(panGestureRecognizer)

        hideRevealBool.bind { (completed) in
            if completed {
                self.hideReveal()
                hideRevealBool.value = false
            }
        }
    }

    @objc func showReveal() {

        if children.count > 0 {
            //Here we are add the WebPdfViewController as childView. So we are checking that one also..
            if children[0] is RevealVC {
                let width = UIScreen.main.bounds.width
                UIView.animate(withDuration: 0.3) { [self] in
                    children[0].view.frame = CGRect(x: 0, y: 0, width: width, height: view.frame.height)
//                    print(children[0].view.frame.origin.x)
                }
            }
        }
    }

    @objc func hideReveal() {

        if children.count > 0 {
            //Here we are add the WebPdfViewController as childView. So we are checking that one also..
            if children[0] is RevealVC {
                let width = UIScreen.main.bounds.width
                UIView.animate(withDuration: 0.3) { [self] in
                    children[0].view.frame = CGRect(x: -width, y: 0, width: width, height: view.frame.height)
                }
            }
        }
    }

    
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
