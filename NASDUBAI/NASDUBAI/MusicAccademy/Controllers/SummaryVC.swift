//
//  SummaryVC.swift
//  NAS
//
//  Created by Mobatia Technology on 24/08/20.
//  Copyright © 2020 AJITH. All rights reserved.
//

import UIKit

//class SummaryVC: UIViewController, selectionDelegate, calederPopUpDelegate {
//
//    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
//    @IBOutlet weak var historyView: UIView!
//    @IBOutlet weak var studentNameTextfield: UITextField!
//    @IBOutlet weak var selectChildLabel: UILabel!
//    @IBOutlet weak var studentViewContainer: UIView!
//    @IBOutlet weak var studentIconView: UIImageView!
//    @IBOutlet weak var tableView: UITableView!
//    var studentList : [StudentList] = []
//    var cartList : [CartList] = []
//    var studId = ""
//    var studentCanteenInfoDict : StudentCantenData = StudentCantenData([:])
//    var staffCanteenInfoDict : StaffCantenData = StaffCantenData([:])
//    var dates = [SelectedDates]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        callStudebtListAPi()
//        setUpUI()
//        // create attributed string
//
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        if studId.count > 0 {
//            //getCartInfo(studentId: studId)
//        }
//        DefaultWrapper.setSelectedStudentId("")
//    }
//    //MARK:  UIpart begin
//    func setUpUI(){
//        studentIconView.layer.cornerRadius = studentIconView.frame.height/2
//        studentIconView.layer.cornerRadius = studentIconView.frame.width / 2
//        studentIconView.clipsToBounds = true
//        studentIconView.layer.borderWidth = 0.5
//        studentIconView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        studentIconView.image = UIImage.init(named: "studentIcon.png")
//        studentViewContainer.layer.cornerRadius = 8
//        studentViewContainer.layer.borderColor = UIColor (named: "NAS_Color_1")?.cgColor
//        studentViewContainer.layer.borderWidth = 1.5
//    }
//    //MARK:  UIpart End
//
//    func getClickedDates(datesArray: [String]) {
//        dates = []
//        let testAraay = dateArrayOrdering(dateArray: datesArray)
//        print("\(testAraay)")
//        for i in 0..<testAraay.count {
//            let dat = SelectedDates.init(testAraay[i])
//            dates.append(dat)
//        }
//        if dates.count > 0 {
//            let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.main)
//            let nextVC = storyboard.instantiateViewController(withIdentifier: "FoodMenuViewController") as! FoodMenuViewController
//            nextVC.dateStringArray = dates
//            nextVC.cartItemList = cartList
//            nextVC.StudID = studId
//            self.navigationController?.pushViewController(nextVC, animated: false)
//        }
//    }
//
//    func dateArrayOrdering(dateArray:[String]) -> [String] {
//        var testArray = dateArray
//        var convertedArray: [Date] = []
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        for dat in testArray {
//            let date = dateFormatter.date(from: dat)
//            if let date = date {
//                convertedArray.append(date)
//            }
//        }
//        testArray = []
//        let ready = convertedArray.sorted(by: { $0.compare($1) == .orderedAscending })
//        for date in ready{
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            testArray.append(dateFormatter.string(from: date))
//        }
//        return testArray
//    }
//
//    @IBAction func backButtonCliked(_ sender: Any){
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    @IBAction func homeButtonCliked(_ sender: Any){
//        let vc = MenuViewController(nibName: "MenuViewController", bundle: nil)
//        self.navigationController!.pushViewController(vc, animated: true)
//    }
//
//    @IBAction func studentDropDownButtonClicked(_ sender: Any){
//        let storyBoard = UIStoryboard(name: "Storyboard", bundle: Bundle.main)
//        let nextVC = storyBoard.instantiateViewController(withIdentifier: "StudentSelectionViewController") as! StudentSelectionViewController
//        nextVC.modalPresentationStyle = .overCurrentContext
//        nextVC.modalTransitionStyle = .crossDissolve
//        nextVC.studentList = self.studentList
//        nextVC.selectedStudent = studentNameTextfield.text
//        nextVC.typeOfPage = .lunchBox
//        nextVC.selectionDelegate = self
//        self.present(nextVC, animated: false, completion: nil)
//    }
//
//
//
//    func selectedStudentData(index: Int) {
//
//        //
//        if index == -1 {
//            studentIconView.image = UIImage.init(named: "studentIcon.png")
//            studentNameTextfield.text = ""
//            studId = ""
//            return
//        }
//
//        //Get StudentData from localDB
//        let data = AppDelegate.getStudentList()
//        guard let arrayOfStudents = data as? [[String: Any]] else {
//            return
//        }
//        //["section": 14ism, "id": 4711, "class": 14, "house": , "photo": , "wallet": 341, "name": tala alawieh]
//        studentList.removeAll()
//        let _ = arrayOfStudents.map( { studentList.append(StudentList($0)) })
//        //
//        setStudentData(index: index)
//    }
//
//    func setStudentData(index : Int) {
//
//        self.studentIconView.image = UIImage.init(named: "studentIcon.png")
//        self.studentNameTextfield.text  = studentList[index].name
//
//        if (studentList[index].photo.count > 0) {
//            let imageUrlString = studentList[index].photo.replacingOccurrences(of: " ", with: "%20")
//            JMImageCache.shared()?.image(for: URL(string: imageUrlString), completionBlock: { (image) in
//                self.studentIconView.image = image
//            }, failureBlock: { (request, response, error) in
//                self.studentIconView.image = UIImage.init(named: "studentIcon.png")
//            })
//        }
//
//      //  orderViewContiner.alpha = 1
//
//        if studentList[index].id.count != 0 {
//            self.studId = studentList[index].id;
//            //getCartInfo(studentId: studId)
//           // callStudentCanteenInfo(studentId: studentList[index].id)
//        }
//    }
//
//    func calculateTotal(){
//        var subTotal = 0
//        var itemCount = 0
//        for i in 0..<cartList.count{
//            for j in 0..<cartList[i].cartitemDetails.count{
//                subTotal += (cartList[i].cartitemDetails[j].qntyInt * cartList[i].cartitemDetails[j].priceInt )
//                itemCount += cartList[i].cartitemDetails[j].qntyInt
//            }
//        }
//        if itemCount > 0 {
//        }else{
//        }
//    }
//
//
//
//
//
//
//    func callStudebtListAPi() {
//
//        self.activityIndicatior.startAnimating()
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
//                }
//                else if (studentListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || studentListResponse.responsecode == RESPONSE_TOKEN_INVALID || studentListResponse.responsecode == RESPONSE_TOKENMISSING){
//                                AppDelegate.showTokenAlert("Alert", "Your session expired. Please Login Again.", 0)
//                }
//            }else{
//                self.activityIndicatior.stopAnimating()
//                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
//            }
//        }
//    }
//
////    func callStudentCanteenInfo(studentId:String) {
////
////        self.activityIndicatior.startAnimating()
////        APIManager.getStudentCanteenInfoAPI(studentId) { (responseDict, responseString, Error) in
////            if Error == nil{
////                self.activityIndicatior.stopAnimating()
////                let studentListResponse = StudentCanteenInfoResponse(responseDict as! [String : Any] )
////                if studentListResponse.responsecode == RESPONSE_SUCCESS{
////                    if studentListResponse.response.statuscode ==  STATUSCODE_SUCCESS {
////                        self.studentCanteenInfoDict = studentListResponse.response.data
////                    }else{
////                        AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
////                    }
////                }else if (studentListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || studentListResponse.responsecode == RESPONSE_TOKEN_INVALID || studentListResponse.responsecode == RESPONSE_TOKENMISSING){
////                    APIManager.getAccessToken { (responseObject, error) in
////                        if error == nil{
////                            let accessToken = responseObject!["access_token"] as! String
////                            if accessToken.count != 0{
////                                self.callStudentCanteenInfo(studentId: studentId)
////                            }else{
////                                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
////                            }
////                        }
////                    }else{
////                        AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
////                    }
////                }else if (studentListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || studentListResponse.responsecode == RESPONSE_TOKEN_INVALID || studentListResponse.responsecode == RESPONSE_TOKENMISSING){
////                    APIManager.getAccessToken { (responseObject, error) in
////                        if error == nil{
////                            let accessToken = responseObject!["access_token"] as! String
////                            if accessToken.count != 0{
////                                self.callStudebtListAPi()
////                            } else{
////                                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
////                            }
////                        }
////                    }
////                }
////            }else{
////                self.activityIndicatior.stopAnimating()
////                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
////            }
////        }
////    }
//
////    func callStudentCanteenInfo(studentId:String) {
////
////        self.activityIndicatior.startAnimating()
////        APIManager.getMusicAcademyInfoAPI(studentId) { (responseDict, responseString, Error) in
////            print(responseString)
////            if Error == nil{
////                self.activityIndicatior.stopAnimating()
////                let studentListResponse = StudentCanteenInfoResponse(responseDict as! [String : Any] )
////                if studentListResponse.responsecode == RESPONSE_SUCCESS{
////                    if studentListResponse.response.statuscode ==  STATUSCODE_SUCCESS {
////                        self.studentCanteenInfoDict = studentListResponse.response.data
////                    }else{
////                        AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
////                    }
////                }else if (studentListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || studentListResponse.responsecode == RESPONSE_TOKEN_INVALID || studentListResponse.responsecode == RESPONSE_TOKENMISSING){
////                    APIManager.getAccessToken { (responseObject, error) in
////                        if error == nil{
////                            let accessToken = responseObject!["access_token"] as! String
////                            if accessToken.count != 0{
////                                self.callStudentCanteenInfo(studentId: studentId)
////                            }else{
////                                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
////                            }
////                        }
////
////                    }
////                }
////            }else{
////                self.activityIndicatior.stopAnimating()
////                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
////            }
////        }
////    }
//
////    func getCartInfo(studentId:String) {
////
////        var userType = "1"
////        if DefaultWrapper.isStaffLoggedIn() {
////            userType = "2"
////        }
////        APIManager.getlMusicAcademySummaryAPI(studentId, andUserType: userType){ (responseDict, responseString, Error) in
////            print(responseString)
////            if Error == nil{
////                self.activityIndicatior.stopAnimating()
////                let cartListResponse = CartListResponse(responseDict as! [String : Any] )
////                if cartListResponse.responsecode == RESPONSE_SUCCESS{
////                    if cartListResponse.response.statuscode ==  STATUSCODE_SUCCESS {
////                        self.cartList = cartListResponse.response.data
////                        self.calculateTotal()
////                        print("... \(self.cartList.count) ...")
////                    }else{
////                    }
////                }else if (cartListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || cartListResponse.responsecode == RESPONSE_TOKEN_INVALID || cartListResponse.responsecode == RESPONSE_TOKENMISSING){
////                    APIManager.getAccessToken { (responseObject, error) in
////                        if error == nil{
////                            let accessToken = responseObject!["access_token"] as! String
////                            if accessToken.count != 0{
////                                self.getCartInfo(studentId: studentId)
////                            }else{
////                            }
////                        }
////
////                    }
////                }
////            }else{
////            }
////        }
////    }
//}

