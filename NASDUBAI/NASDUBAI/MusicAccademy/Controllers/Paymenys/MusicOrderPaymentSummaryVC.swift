//
//  MusicOrderPaymentSummaryVC.swift
//  NAS
//
//  Created by Mobatia Technology on 24/08/20.
//  Copyright © 2020 AJITH. All rights reserved.
//

import UIKit

class MusicOrderPaymentSummaryVC: UIViewController {
    
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var studentNameTextfield: UITextField!
    @IBOutlet weak var selectChildLabel: UILabel!
    @IBOutlet weak var studentViewContainer: UIView!
    @IBOutlet weak var studentIconView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var studentList : [StudentList] = []
    var studId = ""
//    var studentCanteenInfoDict : StudentCantenData = StudentCantenData([:])
//    var staffCanteenInfoDict : StaffCantenData = StaffCantenData([:])
//    var dates = [SelectedDates]()
    var orderSummaryListData: [InstrumentPaymentHistoryModel] = []
    var orderSummaryDictArray: [[String: Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableViewCell()
        self.tableView.separatorStyle = .none
        callStudentListAPI()
        setUpUI()
        // create attributed string
    }
    
    fileprivate func initTableViewCell() {
        self.tableView.register(InstrumentPaymentSummaryTableViewCell.nib, forCellReuseIdentifier: InstrumentPaymentSummaryTableViewCell.identifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        if studId.count > 0 {
            //getCartInfo(studentId: studId)
        }
        //DefaultWrapper.setSelectedStudentId("")
    }
    
    //MARK:  UIpart begin
    func setUpUI(){
        studentIconView.layer.cornerRadius = studentIconView.frame.height/2
        studentIconView.layer.cornerRadius = studentIconView.frame.width / 2
        studentIconView.clipsToBounds = true
        studentIconView.layer.borderWidth = 0.5
        studentIconView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        studentIconView.image = UIImage.init(named: "studentIcon.png")
        studentViewContainer.layer.cornerRadius = 8
        studentViewContainer.layer.borderColor = UIColor (named: "NAS_Color_1")?.cgColor
        studentViewContainer.layer.borderWidth = 1.5
    }
    
    //MARK:  UIpart End
    func dateArrayOrdering(dateArray:[String]) -> [String] {
        var testArray = dateArray
        var convertedArray: [Date] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        for dat in testArray {
            let date = dateFormatter.date(from: dat)
            if let date = date {
                convertedArray.append(date)
            }
        }
        testArray = []
        let ready = convertedArray.sorted(by: { $0.compare($1) == .orderedAscending })
        for date in ready{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            testArray.append(dateFormatter.string(from: date))
        }
        return testArray
    }
    
    @IBAction func backButtonCliked(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeButtonCliked(_ sender: Any){
      
    }
    
    @IBAction func studentDropDownButtonClicked(_ sender: Any){
        let storyBoard = UIStoryboard(name: "HomeStoryboard", bundle: Bundle.main)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "StudentSelectionVC") as! StudentSelectionVC
        nextVC.modalPresentationStyle = .overCurrentContext
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.studentList = self.studentList
//        nextVC.selectedStudent = studentNameTextfield.text
//        nextVC.typeOfPage = .lunchBox
//        nextVC.selectionDelegate = self
        self.present(nextVC, animated: false, completion: nil)
    }
    
    func setStudentData(index : Int) {
        
        self.studentIconView.image = UIImage.init(named: "studentIcon.png")
        self.studentNameTextfield.text  = studentList[index].name
        
        if (studentList[index].photo?.count ?? 0 > 0) {
            let imageUrlString = studentList[index].photo?.replacingOccurrences(of: " ", with: "%20")
//            JMImageCache.shared()?.image(for: URL(string: imageUrlString), completionBlock: { (image) in
//                self.studentIconView.image = image
//            }, failureBlock: { (request, response, error) in
//                self.studentIconView.image = UIImage.init(named: "studentIcon.png")
//            })
        }
        
      //  orderViewContiner.alpha = 1
        
        if studentList[index].id?.count != 0 {
            self.studId = studentList[index].id ?? "";
            //getCartInfo(studentId: studId)
            callInstrumentOrderSummaryAPI(studentId: studentList[index].id ?? "")
        }
    }
    private func setStudentBasedOnStudentID(studIdValue: String) {
        if studIdValue == "" {
            self.setStudentData(index: 0)
            return
        }
        if let indexValue = self.studentList.firstIndex(where: { $0.id == studIdValue }) {
            self.setStudentData(index: indexValue)
        }else {
            self.setStudentData(index: 0)
        }
    }
    private func callStudentListAPI() {
        self.activityIndicatior.startAnimating()
        
    }
    
    func callInstrumentOrderSummaryAPI(studentId:String) {

        self.activityIndicatior.startAnimating()
//        APIManager.getInstrumentPaymentHistoryAPI(studentId) { (responseDict, responseString, Error) in
//            if Error == nil{
//                self.activityIndicatior.stopAnimating()
//                let summaryListResponse = InstrumentPaymentModel(responseDict as! [String : Any] )
//                if summaryListResponse.responsecode == RESPONSE_SUCCESS{
//                    if summaryListResponse.response.statuscode ==  STATUSCODE_SUCCESS {
//                        if let responseToInner = responseDict?["response"] as? [String: Any],
//                           let dataDict = responseToInner["data"] as? [String: Any],
//                           let instrument_data = dataDict["payment_history"] as? [[String: Any]]{
//                            self.orderSummaryDictArray = instrument_data
//                        }
//                        self.orderSummaryListData = summaryListResponse.response.data.paymentHistory
//
//                        if self.orderSummaryListData.count == 0 {
//                            DispatchQueue.main.async {
//                                AppDelegate.showSingleButtonAlert("Alert", "No Data Available", 0)
//                            }
//                        }
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//                    }else{
//                        AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
//                    }
//                }
//                else if (summaryListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || summaryListResponse.responsecode == RESPONSE_TOKEN_INVALID || summaryListResponse.responsecode == RESPONSE_TOKENMISSING){
//                                AppDelegate.showTokenAlert("Alert", "Your session expired. Please Login Again.", 0)
//                }
//            }else{
//                self.activityIndicatior.stopAnimating()
//                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
//            }
//        }
    }
    

}

//MARK: - UITableView Delegate, DataSource
extension MusicOrderPaymentSummaryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderSummaryListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InstrumentPaymentSummaryTableViewCell.identifier, for: indexPath) as? InstrumentPaymentSummaryTableViewCell else { fatalError("xib doesn't exist") }
        let obj = orderSummaryListData[indexPath.row]
        cell.headerLabel.text = obj.order_reference
        //cell.subValue1Label.text = obj.created_on.getDateForMusicPayment()
        cell.amountLabel.text = obj.order_total + " " + "AED"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let nextVc = MusicInvoice(nibName: "MusicInvoicePreviewViewController", bundle: nil)
//        guard self.orderSummaryDictArray.count > 0 else { return }
//        guard self.orderSummaryDictArray.count > indexPath.row else { return }
//        let eachSummary = self.orderSummaryDictArray[indexPath.row]
//        nextVc.dataDict = NSMutableDictionary(dictionary: eachSummary)
//        self.navigationController!.pushViewController(nextVc, animated: true)
    }
}

//MARK: - selectionDelegate
//extension MusicOrderPaymentSummaryVC: selectionDelegate {
//    func selectedStudentData(index: Int) {
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
//}
