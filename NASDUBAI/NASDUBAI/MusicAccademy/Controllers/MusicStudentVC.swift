//
//  MusicStudentVC.swift
//  NAS
//
//  Created by Mobatia Technology on 24/08/20.
//  Copyright © 2020 AJITH. All rights reserved.
//

import UIKit

class MusicStudentVC: UIViewController, selectionDelegate {
    
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var studentNameTextfield: UITextField!
    @IBOutlet weak var selectChildLabel: UILabel!
    @IBOutlet weak var studentViewContainer: UIView!
    @IBOutlet weak var studentIconView: UIImageView!
    
    @IBOutlet weak var chooseMusicInstLabel: UILabel!
    @IBOutlet weak var payableAmt: UILabel!
    @IBOutlet weak var instrumentsTableView: UITableView!
    @IBOutlet weak var paymentView: UIView!
    
    var studentList : [StudentList] = []
    var cartList : [CartList] = []
    var studId = ""
    var studName = ""
    var studentCanteenInfoDict : StudentCantenData = StudentCantenData([:])
    var staffCanteenInfoDict : StaffCantenData = StaffCantenData([:])
    var dates = [SelectedDates]()
    
    var instrumentListDataModel: InstrumentListResponseModel?
    var instrumentResponse: InstrumentResponse?
    var instrumentResponseData: InstrumentResponseData?
    var instrumentListData: [InstrumentListData] = []
    var termData: [TermData] = []
    var lessonData: [LessonData] = []
    
    var instrumentsArray = [""]
    var totalPayableAmount: Double = 0.0
    var selectedIndexForEditDelete: Int = -1
    var orderSummaryListData: [MusicInstrumentCartSummaryOrderListData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.manageUIBasedOnInstrumentList()
        self.callStudentListAPi()
    }
    override func viewWillAppear(_ animated: Bool) {
        if studId.count > 0 {
//            getCartInfo(studentId: studId)
        }
        //DefaultsWrapper().setSelectedStudentId("")
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("DoubleButtonAlertNotification"), object: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        if notification.name.rawValue ==  "DoubleButtonAlertNotification" {
            if notification.object as? String == "deleteSelection" {
                let instrument_id = self.instrumentListData[selectedIndexForEditDelete].instrument_id
                self.cancelCartAPI(studentId: self.studId, instrumentID: "\(instrument_id)")
                self.selectedIndexForEditDelete = -1
            }else if notification.object as? String == "editSelection" {
                self.navigateToDetailsPage(indexValue: selectedIndexForEditDelete)
                self.selectedIndexForEditDelete = -1
            }
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
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
        
        instrumentsTableView.register(UINib(nibName: "InstrumentsTableViewCell", bundle: nil), forCellReuseIdentifier: "InstrumentsTableViewCell")
        self.instrumentsTableView.delegate = self
        self.instrumentsTableView.dataSource = self
        self.instrumentsTableView.alwaysBounceVertical = false
        self.instrumentsTableView.separatorStyle = .none
        self.instrumentsTableView.reloadData()
        paymentView.isHidden = true
    }
    
    @IBAction func backButtonCliked(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeButtonCliked(_ sender: Any){
        pushToHome()
    }
    
    @IBAction func studentDropDownButtonClicked(_ sender: Any){
//        let storyBoard = UIStoryboard(name: "HomeStoryboard", bundle: Bundle.main)
//        let nextVC = storyBoard.instantiateViewController(withIdentifier: "StudentSelectionVC") as! StudentSelectionVC
//        nextVC.modalPresentationStyle = .overCurrentContext
//        nextVC.modalTransitionStyle = .crossDissolve
//        nextVC.studentList = self.studentList
//        nextVC.selectedStudent = studentNameTextfield.text
//        nextVC.typeOfPage = .lunchBox
//        nextVC.selectionDelegate = self
//        self.present(nextVC, animated: false, completion: nil)
    }
    
    @IBAction func paynow_btn(_ sender: Any) {
//        let vc = MusicCartSummaryViewController(nibName: "MusicCartSummaryViewController", bundle: nil)
//        vc.studId = studId
//        vc.studentName = self.studName
//        self.navigationController?.pushViewController(vc, animated: true)
//        vc.submitAndCallAPI = { [weak self] in
//            if self?.studId != "" {
//                self?.callMusicAcademyInstrumentsAPI(studentId: self!.studId)
//            }
//        }
    }
    
    func selectedStudentData(index: Int) {
        if index == -1 {
            studentIconView.image = UIImage.init(named: "studentIcon.png")
            studentNameTextfield.text = ""
            studId = ""
            studName = ""
            return
        }
        
        //Get StudentData from localDB
//        let data = AppDelegate.getStudentList()
//        guard let arrayOfStudents = data as? [[String: Any]] else {
//            return
//        }
//        studentList.removeAll()
//        let _ = arrayOfStudents.map( { studentList.append(StudentList(context: $0)) })
//        setStudentData(index: index)
    }
    
    func setStudentData(index : Int) {
        
        self.studentIconView.image = UIImage.init(named: "studentIcon.png")
        self.studentNameTextfield.text  = studentList[index].name
        
        if (studentList[index].photo!.count > 0) {
            let imageUrlString = studentList[index].photo!.replacingOccurrences(of: " ", with: "%20")
//            JMImageCache.shared()?.image(for: URL(string: imageUrlString), completionBlock: { (image) in
//                self.studentIconView.image = image
//            }, failureBlock: { (request, response, error) in
//                self.studentIconView.image = UIImage.init(named: "studentIcon.png")
//            })
        }
        guard index >= 0 else { return }
        if studentList.count > index {
            self.studId = studentList[index].id!
            self.studName = studentList[index].name!
            callMusicAcademyInstrumentsAPI(studentId: self.studId)
            instrumentsTableView.reloadData()
        }
    }
    
    func needToCallCartSummary() -> Bool {
        var isPayViewToShow = false
        for (_, obj) in instrumentListData.enumerated() {
            if obj.instrument_selected == true {
                isPayViewToShow = true
            }
        }
        return isPayViewToShow
    }
    
    func showPayView(show: Bool) {
        self.paymentView.isHidden = !show
    }
    
    func calculateTotal(){
        var subTotal: Double = 0
        self.totalPayableAmount = 0.0
        for (_, obj) in orderSummaryListData.enumerated() {
            for (_, objJValue) in obj.order_data.enumerated(){
                subTotal += Double(objJValue.total_amount) ?? 0.0
            }
        }
        self.totalPayableAmount = subTotal
    }
    
    func showTotalValue() {
        self.payableAmt.text = "\(self.totalPayableAmount) AED"
    }
}

//MARK: - TableView Delegate, DataSource
extension MusicStudentVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instrumentListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "InstrumentsTableViewCell") as? InstrumentsTableViewCell {
            cell.instrumentNameLabel.text = instrumentListData[indexPath.row].instrument_name
            cell.selectionStyle = .none
            if instrumentListData[indexPath.row].instrument_selected == true {
                cell.selectedImageView.image = UIImage(named: "approve")
            }else {
                cell.selectedImageView.image = UIImage(named: "calendarRightArrow")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.instrumentListData[indexPath.row].term_data.count == 0 {
          //  AppDelegate.showSingleButtonAlert("Alert", "No Class Available", 0)
            return
        }
        if instrumentListData[indexPath.row].instrument_selected == true {
            selectedIndexForEditDelete = indexPath.row
            //AppDelegate.showDoubleButtonAlert("Delete or Edit Selection?", "You hae selected course for this instrument. Do you want to cancel or edit the selection", 8245)
            return
        }
        self.navigateToDetailsPage(indexValue: indexPath.row)
    }
    
    func navigateToDetailsPage(indexValue: Int) {
        let vc = MusicInstrumentsVC(nibName: "MusicInstrumentsVC", bundle: nil)
        vc.dataObj = self.instrumentListData[indexValue]
        vc.instrumentSelected = self.instrumentListData[indexValue].instrument_name
        vc.studId = studId
        self.navigationController?.pushViewController(vc, animated: true)
        vc.submitAndCallAPI = { [weak self] in
            if self?.studId != "" {
                self?.callMusicAcademyInstrumentsAPI(studentId: self!.studId)
            }
        }
    }
}

//MARK: - API Calls
extension MusicStudentVC {
    private func cancelCartAPI(studentId:String, instrumentID: String) {
        self.activityIndicatior.startAnimating()
        
    }
    
    private func callStudentListAPi() {
        self.activityIndicatior.startAnimating()
         
    }
    
    private func manageUIBasedOnInstrumentList() {
        if self.instrumentListData.count == 0 {
            self.instrumentsTableView.alpha = 0
            self.chooseMusicInstLabel.alpha = 0
        }else {
            self.instrumentsTableView.alpha = 1
            self.chooseMusicInstLabel.alpha = 1
        }
    }
    
    private func showNoDataAlert() {
        if self.instrumentListData.count == 0 {
            //presentSingleBtnAlert(message: "Alert", "No data available")
            
        }
    }
    
    private func callMusicAcademyInstrumentsAPI(studentId:String) {
        
        self.activityIndicatior.startAnimating()
        
    }
    
    func callInstrumentCartSummaryAPI(studentId:String) {
        self.activityIndicatior.startAnimating()
        
    }
}

