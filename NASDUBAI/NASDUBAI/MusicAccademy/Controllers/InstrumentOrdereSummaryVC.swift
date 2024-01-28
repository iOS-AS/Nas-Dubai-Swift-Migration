//
//  InstrumentOrdereSummaryVC.swift
//  NAS
//
//  Created by Mobatia Technology on 24/08/20.
//  Copyright © 2020 AJITH. All rights reserved.
//

import UIKit

class InstrumentOrdereSummaryVC: UIViewController {
    
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
    var orderSummaryListData: [InstrumentOrderListData] = []
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
        self.tableView.register(InstrumentOrdereSummaryTableViewCell.nib, forCellReuseIdentifier: InstrumentOrdereSummaryTableViewCell.identifier)
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
    
    private func callStudentListAPI() {
        self.activityIndicatior.startAnimating()
        
    }
    
    func callInstrumentOrderSummaryAPI(studentId:String) {

        self.activityIndicatior.startAnimating()
        
    }
    

}

//MARK: - UITableView Delegate, DataSource
extension InstrumentOrdereSummaryVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderSummaryListData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        //        headerView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        headerView.backgroundColor = .white
        let label = UILabel()
        label.frame = CGRect.init(x: 10, y: 5, width: headerView.frame.width-20, height: headerView.frame.height-10)
        label.text = orderSummaryListData[section].intrument_name
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .darkGray
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderSummaryListData[section].order_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InstrumentOrdereSummaryTableViewCell.identifier, for: indexPath) as? InstrumentOrdereSummaryTableViewCell else { fatalError("xib doesn't exist") }
        let obj = orderSummaryListData[indexPath.section].order_data[indexPath.row]
        cell.headerLabel.text = obj.lesson_name
        cell.subValue1Label.text = obj.amount + " " + obj.currency
        cell.subValue2Label.text = obj.term_name
        cell.selectionStyle = .none
        if indexPath.row == orderSummaryListData[indexPath.section].order_data.count - 1 {
            cell.dividerView.alpha = 1
        }else {
            cell.dividerView.alpha = 0
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - selectionDelegate
//extension InstrumentOrdereSummaryVC: selectionDelegate {
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
//MARK: - Action
extension InstrumentOrdereSummaryVC {
    @IBAction func invoiceButtonCliked(_ sender: Any){
        let vc = MusicOrderPaymentSummaryVC(nibName: "MusicOrderPaymentSummaryVC ", bundle: nil)
        vc.studId = self.studId
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func backButtonCliked(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeButtonCliked(_ sender: Any){
        pushToHome()
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
}
