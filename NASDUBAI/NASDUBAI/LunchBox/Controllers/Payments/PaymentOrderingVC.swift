//
//  PaymentOrderingVC.swift
//  NAS
//
//  Created by Mobatia Technology on 24/08/20.
//  Copyright © 2020 AJITH. All rights reserved.
//

import UIKit
import NISdk
import PassKit

@objc protocol paymentOrderDelegate: NSObjectProtocol  {
   @objc func paymentStatus(status:String)
}
class PaymentOrderingVC: UIViewController {
   
//   MARK: Payment
    var selectedItems: [Product] = []
    var total: Double = 0.0
    let apiCalls = APICalls()
    var orderReference = ""
    @objc public var amountSTR:String  = ""
    @objc  public var StudentName:String  = ""
    @objc var timeStampStr = ""
    @objc var paymentDelegate: paymentOrderDelegate?
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        activityIndicator.startAnimating()
        super.viewDidLoad()
        print("stud \(StudentName).....\(amountSTR).....\(timeStampStr)")
        total = Double(amountSTR)!
        total *= 100
        NISdk.sharedInstance.setSDKLanguage(language: "en")
        callingSDKFunction()
    }
}

extension PaymentOrderingVC: CardPaymentDelegate{
    func callingSDKFunction() {
        apiCalls.generateNPGAccessToken_Fee_Payment {
            DispatchQueue.main.async {
                self.apiCalls.createNPGOrder_Fee_Payment(amount: Int(self.total), emailAddress: DefaultsWrapper().getUserEmailID(), merchantOrderReference: self.timeStampStr, firstName:self.StudentName , lastName: self.StudentName, address1: "NAS Dubai", city: "Dubai", countryCode: "UAE", completion: { orderResponse in
//                DispatchQueue.main.async {
//                    self.orderReference = orderResponse.reference ?? ""
////                    self.amountSTR = "10"
//                    let orderCreationViewController = OrderCreationViewController(orderResponse: orderResponse, paymentAmount: self.total, and: self, using: .Card, with: self.selectedItems)
//                    orderCreationViewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
//                    orderCreationViewController.modalPresentationStyle = .overCurrentContext
//                    self.present(orderCreationViewController, animated: false, completion: nil)
//                }
            })
        }
    }
    }
//    @IBAction func payBtnTapped(_ sender: UIButton) {
//         if enterAmountTextField.text == ""{
//                   AppDelegate.showSingleButtonAlert("Alert", "Please enter amount", 0)
//                    return
//                }
//
//    AppDelegate.showSingleButtonAlert("Alert", "Payment Gateway under construction", 0)
//        return
//    }
    
        
        func showAlertWith(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        @objc func paymentDidComplete(with status: PaymentStatus) {
            if(status == .PaymentSuccess) {
                self.paymentDelegate?.paymentStatus(status: "Success")
                   dismissViewCont()
            } else if(status == .PaymentFailed) {
                self.paymentDelegate?.paymentStatus(status: "Failed")
                 dismissViewCont()
            } else if(status == .PaymentCancelled) {
                self.paymentDelegate?.paymentStatus(status: "Aborted")
                 dismissViewCont()
            }
        }
        
        @objc func authorizationDidComplete(with status: AuthorizationStatus) {
            if(status == .AuthFailed) {
                print("Auth Failed :(")
                return
            }
             print("Auth Passed :)")
        }
    @IBAction func backButtonCliked(_ sender: Any){
        dismissViewCont()
    }
    func dismissViewCont() {
           DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
               self.dismiss(animated: false, completion: nil)
           }
       }
}
