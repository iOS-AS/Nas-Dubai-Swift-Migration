//
//  LoginVC.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 27/12/23.
//

import UIKit
import MessageUI

class LoginVC: UIViewController {

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    var loginModel = LoginModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func EmailPress(_ sender: UIButton) {
        
        showEmail()
        
    }
    
    @IBAction func GuestPress(_ sender: UIButton) {
        pushToHome()
    }
    
    @IBAction func ForgotPasswordPress(_ sender: UIButton) {
    }
    
    @IBAction func SignUpPress(_ sender: UIButton) {
        
    }
    
    @IBAction func LoginPress(_ sender: UIButton) {
        
        view.isUserInteractionEnabled = false
        loginModel.callLoginApi(email: Username.text ?? "", password: Password.text ?? "") { [self] (completed, message) in
            
            view.isUserInteractionEnabled = true
            if completed {
                DefaultsWrapper().setUserEmailID(Username.text ?? "")
                loginModel.getStudentList {
                    pushToHome()
                }
            } else {
                alertMessage.value = message
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
  

}

extension LoginVC: MFMailComposeViewControllerDelegate {
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
