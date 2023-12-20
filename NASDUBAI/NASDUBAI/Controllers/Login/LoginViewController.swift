//
//  LoginViewController.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 06/11/23.
//

import UIKit
import MessageUI

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    var loginModel = LoginModel()

     override func viewDidLoad() {
        super.viewDidLoad()
        showAlerts()

//#if DEBUG
//        emailField.text = "iostest@test.com"
//        passwordField.text = "100"
//        emailField.text = "aparna.mohan@mobatia.com"
//        passwordField.text = "71028845"
//        emailField.text = "aparna.mohan@mobatia.com"
//        passwordField.text = "100"
//#endif
    }
    @IBAction func loginPressed(_ sender: UIButton) {

        view.isUserInteractionEnabled = false
        loginModel.callLoginApi(email: emailField.text ?? "", password: passwordField.text ?? "") { [self] (completed, message) in
            
            view.isUserInteractionEnabled = true
            if completed {
                DefaultsWrapper().setUserEmailID(emailField.text ?? "")
                loginModel.getStudentList {
                    pushToHome()
                }
            } else {
                alertMessage.value = message
            }
        }
    }
    @IBAction func parentSignupPressed(_ sender: UIButton) {
      //  presentSignUp()
    }
    @IBAction func emailHelpPressed(_ sender: UIButton) {
        showEmail()
    }
    @IBAction func forgotPWPressed(_ sender: UIButton) {
      //  presentForgotPWVC()
    }
    @IBAction func guestPressed(_ sender: UIButton) {
        pushToHome()
    }
    

}


extension LoginViewController: MFMailComposeViewControllerDelegate {
    fileprivate func showEmail() {
        if MFMailComposeViewController.canSendMail() {
            let emailPicker = MFMailComposeViewController()
            emailPicker.mailComposeDelegate = self
            emailPicker.modalPresentationStyle = .fullScreen
            emailPicker.modalTransitionStyle = .coverVertical
            emailPicker.setToRecipients(["it.help@nasabudhabi.ae"])
            emailPicker.setSubject("")
            emailPicker.setMessageBody("", isHTML: true)
            emailPicker.navigationBar.barStyle = .black
            present(emailPicker, animated: true, completion: nil)
        } else {
            presentSingleBtnAlert(message: "Please configure email on device to use this feature.")
        }

    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}
