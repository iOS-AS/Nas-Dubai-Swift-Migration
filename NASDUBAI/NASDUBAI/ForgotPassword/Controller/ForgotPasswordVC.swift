//
//  ForgotPasswordVC.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 02/01/24.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var emailIDTxt: UITextField!
    
    let forgotPwModel = ForgotPasswordModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconImage.setWhiteBorder()
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        view.zoomIn(bgBtn) {}
    }

    @IBAction func cancelBtn(_ sender: UIButton) {
        
                view.zoomOut(bgBtn) {
                    self.dismiss(animated: false, completion: nil)
                }
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
        
                view.isUserInteractionEnabled = false
        
                forgotPwModel.callForgotPwApi(email: emailIDTxt.text ?? "") { [self] (completed, message)  in
        
                    view.isUserInteractionEnabled = true
        
                    if completed {
                        view.zoomOut(bgBtn) {
                            self.dismiss(animated: false) {
                                alertMessage.value = message
                            }
                        }
                    } else {
                        alertMessage.value = message
                    }

                    view.zoomOut(bgBtn) {
                        self.dismiss(animated: false) {
                            alertMessage.value = "Password successfully sent to your email. Please check."
                        }
                    }
                }
    }
    
    //    @IBAction func cancelPressed(_ sender: UIButton) {
//        view.zoomOut(bgBtn) {
//            self.dismiss(animated: false, completion: nil)
//        }
//
//    }
//    @IBAction func submitPressed(_ sender: UIButton) {
//
//        view.isUserInteractionEnabled = false
//
//        forgotPwModel.callForgotPwApi(email: emailIDTxt.text ?? "") { [self] (completed, message)  in
//
//            view.isUserInteractionEnabled = true
//
//            if completed {
//                view.zoomOut(bgBtn) {
//                    self.dismiss(animated: false) {
//                        alertMessage.value = message
//                    }
//                }
//            } else {
//                alertMessage.value = message
//            }

//            view.zoomOut(bgBtn) {
//                self.dismiss(animated: false) {
//                    alertMessage.value = "Password successfully sent to your email. Please check."
//                }
//            }
//        }
//    }

}
