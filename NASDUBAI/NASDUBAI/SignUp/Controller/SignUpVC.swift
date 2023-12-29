//
//  SignUpVC.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 29/12/23.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var BgBtn: UIButton!
    @IBOutlet weak var IconImage: UIImageView!
    @IBOutlet weak var EmailTxt: UITextField!
    
    let signupModel = SignUpModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IconImage.setWhiteBorder()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        view.zoomIn(BgBtn) {}
    }

    @IBAction func MayBeLaterBtn(_ sender: UIButton) {
        view.zoomOut(BgBtn) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    @IBAction func SignUpBtn(_ sender: UIButton) {
        
        view.isUserInteractionEnabled = false

        signupModel.callSignupApi(email: EmailTxt.text!) { [self] (completed, message)  in

            view.isUserInteractionEnabled = true

            if completed {
                view.zoomOut(BgBtn ) {
                    self.dismiss(animated: false) {
                        alertMessage.value = message
                    }
                }

            } else {
                alertMessage.value = message
            }

//            view.zoomOut(bgBtn) {
//                self.dismiss(animated: false) {
//                    alertMessage.value = "Successfully registered. Please check your email for further details."
//                }
//            }
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
