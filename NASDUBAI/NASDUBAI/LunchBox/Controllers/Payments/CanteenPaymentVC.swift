//
//  CanteenPaymentVC.swift
//  NAS
//
//  Created by Mobatia Technology on 24/08/20.
//  Copyright © 2020 AJITH. All rights reserved.
//

import UIKit
import NISdk
import PassKit

//class CanteenPaymentVC: UIViewController, selectionDelegate, UITextFieldDelegate {
//
//    @IBOutlet var addToWalletButton: UIButton!
//    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
//    @IBOutlet weak var historyView: UIView!
//    @IBOutlet weak var studentNameTextfield: UITextField!
//    @IBOutlet weak var selectChildLabel: UILabel!
//    @IBOutlet weak var studentViewContainer: UIView!
//    @IBOutlet weak var studentIconView: UIImageView!
//    @IBOutlet weak var wallentAmountLabel: UILabel!
//    @IBOutlet weak var enterAmountTextField: UITextField!
//    @IBOutlet weak var wallentAmountContainerView: UIView!
//    @IBOutlet weak var dropDwonArrowImageView: UIImageView!
//    @IBOutlet weak var studentDropDwonButton: UIButton!
//    @IBOutlet weak var homeButton: UIButton!
//    @IBOutlet weak var backButton: UIButton!
//    var isFromPaymentPage:Bool = false
//
//    var studentList : [StudentList] = []
//    var studId = ""
//    var studentCanteenInfoDict : StudentWalletResponse = StudentWalletResponse([:])
//    //   MARK: Payment
//    var selectedItems: [Product] = []
//    var total: Double = 0.0
//    let apiCalls = APICalls()
//    var orderReference = ""
//    var order_id = ""
//    var amountSTR = ""
//    var timeStampStr = ""
//    var WalletLimit: Double = 0.0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if DefaultWrapper.isStaffLoggedIn() {
//            callStaffCanteenInfo()
//        }else{
//            callStudebtListAPi()
//        }
//        enterAmountTextField.delegate = self
//        setUpUI()
//        NISdk.sharedInstance.setSDKLanguage(language: "en")
//        enterAmountTextField.doneAccessory = true
//        NotificationCenter.default.addObserver(self, selector: #selector(CanteenPaymentVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(CanteenPaymentVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//    }
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//        self.view.frame.origin.y = -30
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        self.view.frame.origin.y = 0
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    //MARK:  UIpart begin
//    func setUpUI(){
//
//        self.wallentAmountContainerView.layer.cornerRadius = 8
//        //MARK:- Shade a view
//        self.wallentAmountContainerView.layer.shadowOpacity = 0.5
//        self.wallentAmountContainerView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        self.wallentAmountContainerView.layer.shadowRadius = 5.0
//        self.wallentAmountContainerView.layer.shadowColor = UIColor.black.cgColor
//        self.wallentAmountContainerView.layer.masksToBounds = false
//        studentIconView.layer.cornerRadius = studentIconView.frame.height/2
//        studentIconView.layer.cornerRadius = studentIconView.frame.width / 2
//        studentIconView.clipsToBounds = true
//        studentIconView.layer.borderWidth = 0.5
//        studentIconView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        if DefaultWrapper.isStaffLoggedIn() {
//            studentIconView.image = UIImage.init(named: "teacherIcon.png")
//            studentNameTextfield.text = "Staff"
//            dropDwonArrowImageView.alpha = 0
//            selectChildLabel.alpha = 0
//            studentDropDwonButton.isUserInteractionEnabled = false
//            historyView.alpha = 1
//        }else{
//            studentIconView.image = UIImage.init(named: "studentIcon.png")
//        }
//        studentViewContainer.layer.cornerRadius = 8
//        studentViewContainer.layer.borderColor = UIColor (named: "NAS_Color_1")?.cgColor
//        studentViewContainer.layer.borderWidth = 1.5
//    }
//
//    //MARK:  UIpart End
//    @IBAction func backButtonCliked(_ sender: Any){
//
//        if isFromPaymentPage {
//            if DefaultWrapper.isStaffLoggedIn() {
//                let vc = CanteenStaffViewController(nibName: "CanteenStaffViewController", bundle: nil)
//                self.navigationController!.pushViewController(vc, animated: true)
//            }else{
//                let vc = CanteenStudentViewController(nibName: "CanteenStudentViewController", bundle: nil)
//                self.navigationController!.pushViewController(vc, animated: true)
//            }
//        }else{
//            self.navigationController?.popViewController(animated: true)
//        }
//
//    }
//
//    @IBAction func homeButtonCliked(_ sender: Any){
//
//        let vc = CanteenMenuViewController(nibName: "CanteenMenuViewController", bundle: nil)
//        self.navigationController!.pushViewController(vc, animated: true)
//    }
//
//    @IBAction func historyButtonCliked(_ sender: Any){
//
//        let vc = CanteenTransactionHistoryViewController(nibName: "CanteenTransactionHistoryViewController", bundle: nil)
//        vc.studentID = studId
//        self.navigationController!.pushViewController(vc, animated: true)
//    }
//
//    @IBAction func studentDropDownButtonClicked(_ sender: Any){
//
//        let storyBoard = UIStoryboard(name: "Storyboard", bundle: Bundle.main)
//        let nextVC = storyBoard.instantiateViewController(withIdentifier: "StudentSelectionViewController") as! StudentSelectionViewController
//        nextVC.modalPresentationStyle = .overCurrentContext
//        nextVC.modalTransitionStyle = .crossDissolve
//        nextVC.studentList = self.studentList
//        nextVC.selectedStudent = studentNameTextfield.text
//        nextVC.typeOfPage = .lunchBox
//        nextVC.selectionDelegate = self
//        self.present(nextVC, animated: true, completion: nil)
//    }
//
//    func selectedStudentData(index: Int) {
//
//        //
//        if index == -1 {
//            studentIconView.image = UIImage.init(named: "studentIcon.png")
//            studentNameTextfield.text = ""
//            studId = ""
//            wallentAmountLabel.text = "0 AED"
//            return
//        }
//
//        //Get StudentData from localDB
//        let data = AppDelegate.getStudentList()
//        guard let arrayOfStudents = data as? [[String: Any]] else {
//            return
//        }
//        studentList.removeAll()
//        let _ = arrayOfStudents.map( { studentList.append(StudentList($0)) })
//        //
//        setStudentData(index: index)
//    }
//
//    func setStudentData(index : Int){
//
//        self.wallentAmountLabel.text = "0 AED"
//        self.enterAmountTextField.text = ""
//        self.studentIconView.image = UIImage.init(named: "studentIcon.png")
//        self.studentNameTextfield.text  = studentList[index].name
//        DefaultWrapper.setSelectedStudentId(studentList[index].id)
//        if (studentList[index].photo.count > 0) {
//            let imageUrlString = studentList[index].photo.replacingOccurrences(of: " ", with: "%20")
//            JMImageCache.shared()?.image(for: URL(string: imageUrlString), completionBlock: { (image) in
//                self.studentIconView.image = image
//            }, failureBlock: { (request, response, error) in
//                self.studentIconView.image = UIImage.init(named: "studentIcon.png")
//            })
//        }
//        if studentList[index].id.count != 0 {
//            self.studId = studentList[index].id;
//            callStudentCanteenInfo(studentId: studentList[index].id)
//        }
//    }
//
//    func callStudebtListAPi() {
//
//        self.activityIndicatior.startAnimating()
//
//        APIManager.getStudentList { (responseDict, responseString, Error) in
//            if Error == nil{
//                self.activityIndicatior.stopAnimating()
//                let studentListResponse = StudentListApiresp(responseDict as! [String : Any] )
//                if studentListResponse.responsecode == RESPONSE_SUCCESS{
//                    if studentListResponse.response.statuscode ==  STATUSCODE_SUCCESS {
//                        if studentListResponse.response.data.count == 0 {
//                            AppDelegate.showSingleButtonAlert("Alert", "No Student Data Available", 0)
//                        }else{
//                            self.studentList = studentListResponse.response.data
//                            self.setStudentData(index: 0)
//                        }
//                    }else{
//                        AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
//                    }
//                }else if (studentListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || studentListResponse.responsecode == RESPONSE_TOKEN_INVALID || studentListResponse.responsecode == RESPONSE_TOKENMISSING){
//                    AppDelegate.showTokenAlert("Alert", "Your session expired. Please Login Again.", 0)
//
//    }
//            }else{
//                self.activityIndicatior.stopAnimating()
//                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
//            }
//        }
//    }
//
//    func callStudentCanteenInfo(studentId:String) {
//
//        self.activityIndicatior.startAnimating()
//
//        APIManager.getStudentCanteenWalletInfoAPI(studentId) { (responseDict, responseString, Error) in
//            if Error == nil{
//                self.activityIndicatior.stopAnimating()
//                let studentListResponse = StudentWalletInfoResponse(responseDict as! [String : Any] )
//                if studentListResponse.responsecode == RESPONSE_SUCCESS{
//                    if studentListResponse.response.statuscode ==  STATUSCODE_SUCCESS {
//                        self.studentCanteenInfoDict = studentListResponse.response
//                        self.wallentAmountLabel.text = "\(self.studentCanteenInfoDict.walletAmount) AED"
//                        if self.studentCanteenInfoDict.topupLimit.isInt() {
//                            self.WalletLimit = Double(Int(self.studentCanteenInfoDict.topupLimit) ?? 0)
//                        }
//                        if self.studentCanteenInfoDict.topupLimit.isDouble() {
//                            self.WalletLimit = Double(self.studentCanteenInfoDict.topupLimit) ?? 0
//                        }
//                    }else{
//                        AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
//                    }
//                }else if (studentListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || studentListResponse.responsecode == RESPONSE_TOKEN_INVALID || studentListResponse.responsecode == RESPONSE_TOKENMISSING){
//                    AppDelegate.showTokenAlert("Alert", "Your session expired. Please Login Again.", 0)
//
//    }
//            }else{
//                self.activityIndicatior.stopAnimating()
//                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
//            }
//        }
//    }
//    func callStaffCanteenInfo() {
//
//        self.activityIndicatior.startAnimating()
//
//        APIManager.geStaffCanteenInfoAPI(DefaultWrapper.getLoggedInUserId()) { (responseDict, responseString, Error) in
//            if Error == nil{
//                self.activityIndicatior.stopAnimating()
//                let studentListResponse = StaffCanteenInfoResponse(responseDict as! [String : Any] )
//                if studentListResponse.responsecode == RESPONSE_SUCCESS{
//                    if studentListResponse.response.statuscode ==  STATUSCODE_SUCCESS {
//                        self.studentNameTextfield.text = studentListResponse.response.data.name
//                        self.callStaffCanteenWalletInfo()
//                        //                        self.getCartInfo(studentId: "")
//                    }else{
//                        AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
//                    }
//                }else if (studentListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || studentListResponse.responsecode == RESPONSE_TOKEN_INVALID || studentListResponse.responsecode == RESPONSE_TOKENMISSING){
//                    AppDelegate.showTokenAlert("Alert", "Your session expire. Please Login Again.", 0)
//
//    }
//            }else{
//                self.activityIndicatior.stopAnimating()
//                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
//            }
//        }
//    }
//    func callStaffCanteenWalletInfo() {
//
//        self.activityIndicatior.startAnimating()
//
//        APIManager.getStaffCanteenWalletInfoAPI { (responseDict, responseString, Error) in
//            if Error == nil{
//                self.activityIndicatior.stopAnimating()
//                let studentListResponse = StudentWalletInfoResponse(responseDict as! [String : Any] )
//                if studentListResponse.responsecode == RESPONSE_SUCCESS{
//                    if studentListResponse.response.statuscode ==  STATUSCODE_SUCCESS {
//                        self.studentCanteenInfoDict = studentListResponse.response
//                        self.wallentAmountLabel.text = "\(self.studentCanteenInfoDict.walletAmount) AED"
//                        if self.studentCanteenInfoDict.topupLimit.isInt() {
//                            self.WalletLimit = Double(Int(self.studentCanteenInfoDict.topupLimit) ?? 0)
//                        }
//                        if self.studentCanteenInfoDict.topupLimit.isDouble() {
//                            self.WalletLimit = Double(self.studentCanteenInfoDict.topupLimit) ?? 0
//                        }
//
//                    }else{
//                        AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
//                    }
//                }else if (studentListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || studentListResponse.responsecode == RESPONSE_TOKEN_INVALID || studentListResponse.responsecode == RESPONSE_TOKENMISSING){
//                    AppDelegate.showTokenAlert("Alert", "Your session expired. Please Login Again.", 0)
//
//    }
//            }else{
//                self.activityIndicatior.stopAnimating()
//                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
//            }
//        }
//    }
//
//
//    func callWalletSubmitAPI(studId: String, order_id: String) {
//
//        self.activityIndicatior.startAnimating()
//        timeStampStr = ""
//        if self.order_id == "" {
//            return
//        }
//
//        APIManager.callWalletSubmitAPI(studId, andOrder_id: order_id) { (responseDict, responseString, Error) in
//
//            if Error == nil{
//                self.userIntractionEnable()
//                self.activityIndicatior.stopAnimating()
//                let studentListResponse = WalletSubmitApiResponse(responseDict as! [String : Any] )
//                if studentListResponse.responsecode == RESPONSE_SUCCESS{
//                    if studentListResponse.response.statuscode ==  STATUSCODE_SUCCESS {
//                        if studentListResponse.response.canteenStatusCode == "1"{
//                            AppDelegate.showSingleButtonAlert("Payment Successful", "Thank you!", 1)
//                            self.order_id = ""
//                            DefaultWrapper.setTransactionAmount("")
//                            if DefaultWrapper.isStaffLoggedIn() {
//                                self.callStaffCanteenWalletInfo()
//                            }else{
//                                self.callStudentCanteenInfo(studentId: self.studId)
//                            }
//                        }else{
//                            AppDelegate.showSingleButtonAlert("Alert", "\(studentListResponse.response.message)", 0)
//                        }
//                    }else{
//                        AppDelegate.showSingleButtonAlert("Alert", "\(studentListResponse.response.message)", 0)
//                    }
//                }else if (studentListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || studentListResponse.responsecode == RESPONSE_TOKEN_INVALID || studentListResponse.responsecode == RESPONSE_TOKENMISSING){
//                    AppDelegate.showTokenAlert("Alert", "Your session expired. Please Login Again.", 0)
//
//    }
//            }else{
//                self.userIntractionEnable()
//                self.activityIndicatior.stopAnimating()
//                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
//            }
//        }
//    }
//}

//extension CanteenPaymentVC: CardPaymentDelegate {
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        let dotString = "."
//        if let text = textField.text {
//            let isDeleteKey = string.isEmpty
//            
//            if !isDeleteKey {
//                if text.contains(dotString) {
//                    if text.components(separatedBy: dotString)[1].count == 2 {
//                        
//                        return false
//                        
//                    }
//                    
//                }
//                
//            }
//        }
//        return true
//    }
//    
//    @IBAction func payBtnTapped(_ sender: UIButton) {
//        
//        self.enterAmountTextField.endEditing(true)
//        if self.studentNameTextfield.text == "" {
//            AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
//            return
//        }
//        if enterAmountTextField.text == "" || enterAmountTextField.text == "0" {
//            AppDelegate.showSingleButtonAlert("Alert", "Please enter amount", 0)
//            return
//        }
//        total = Double(enterAmountTextField.text!)!
//        if total > WalletLimit {
//            AppDelegate.showSingleButtonAlert("Alert", "Allow only up to \(self.studentCanteenInfoDict.topupLimit) AED on a single transaction", 0)
//            return
//        }
//        addToWalletButton.isUserInteractionEnabled = false
//        self.view.isUserInteractionEnabled = false
//        //        total *= 100
//        timeStampStr = "\(studId)\(Date.currentTimeStamp)"
//        self.activityIndicatior.startAnimating()
//       
//        //  new
//        
//                    self.apiCalls.createNPGOrder(amount: Int(self.total), studId: studId) { (orderResponse) in
//                        print(orderResponse)
//                        DispatchQueue.main.async {
//                            self.activityIndicatior.stopAnimating()
//                            self.view.isUserInteractionEnabled = true
//                            self.orderReference = orderResponse.order_reference ?? ""
//                            self.order_id = orderResponse.order_id ?? ""
//                            self.amountSTR = self.enterAmountTextField.text ?? ""
//                            DefaultWrapper.setTransactionAmount(self.amountSTR)
//                            self.timeStampStr = orderResponse.merchantOrderReference ?? ""
//                            
//                            if let data = orderResponse.data {
//                                let orderCreationViewController = OrderCreationViewController(orderResponse: data, paymentAmount: self.total, and: self, using: .Card, with: self.selectedItems)
//                                orderCreationViewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
//                                orderCreationViewController.modalPresentationStyle = .overCurrentContext
//                                self.present(orderCreationViewController, animated: false, completion: nil)
//                            }
//                        }
//                    }
//                
//               
//            
//        
//    }
//    
//    func showAlertWith(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
//    
//    @objc func paymentDidComplete(with status: PaymentStatus) {
//        DispatchQueue.main.async { [self] in
//            self.enterAmountTextField.text = ""
//            self.addToWalletButton.isUserInteractionEnabled = true
//        }
//        //        Payment SDK Callback
//        
//        if(status == .PaymentSuccess) {
//            print("........PaymentSuccess........")
//            setStudentWalletSubmitData(true)
//            return
//        } else if(status == .PaymentFailed) {
//            showAlertWith(title: "Payment Failed", message: "Your Payment could not be completed.")
//            return
//        } else if(status == .PaymentCancelled) {
//            showAlertWith(title: "Payment Aborted", message: "You cancelled the payment request. You can try again!")
//            return
//        }
//        
//    }
//    
//    @objc func authorizationDidComplete(with status: AuthorizationStatus) {
//        if(status == .AuthFailed) {
//            print("Auth Failed :(")
//            return
//        }
//        print("Auth Passed :)")
//    }
//    
//    func setStudentWalletSubmitData(_ isSucccess: Bool){
//        if isSucccess {
//            self.view.isUserInteractionEnabled = false
//            backButton.isUserInteractionEnabled = false
//            homeButton.isUserInteractionEnabled = false
//            callWalletSubmitAPI(studId: studId, order_id: order_id)
//        }
//    }
//    
//    func userIntractionEnable() {
//        self.view.isUserInteractionEnabled = true
//        backButton.isUserInteractionEnabled = true
//        homeButton.isUserInteractionEnabled = true
//    }
//    
//}
