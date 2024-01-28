//
//  MusicCartSummaryVC.swift
//  NAS
//
//  Created by Mobatia Technology on 24/08/20.
//  Copyright © 2020 AJITH. All rights reserved.
//

import UIKit

class MusicCartSummaryVC: UIViewController {
    
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    var totalPayableAmount: Double = 0.0
    var studId = ""
    var studentName = ""
    var orderSummaryListData: [MusicInstrumentCartSummaryOrderListData] = []
    var orderIdStr = ""
    var submitAndCallAPI: () -> () = { }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.totalAmountLabel.text = ""
        self.initTableViewCell()
        self.tableView.separatorStyle = .none
        self.callInstrumentCartSummaryAPI(studentId: studId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("SingleButtonAlertNotification"), object: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        if notification.name.rawValue ==  "SingleButtonAlertNotification" {
            if notification.object as? String == "classBookerMusic" {
                self.navigationController?.popViewController(animated: true)
                self.submitAndCallAPI()
            }
        }
    }
    
    private func initTableViewCell() {
        self.tableView.register(InstrumentOrdereSummaryTableViewCell.nib, forCellReuseIdentifier: InstrumentOrdereSummaryTableViewCell.identifier)
    }
}

//MARK: - Action
extension MusicCartSummaryVC {
    @IBAction func backButtonCliked(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeButtonCliked(_ sender: Any){
        
    }
    
    @IBAction func proceedToCheckoutButtonTapped() {
//        let nextVC = PaymentOrderView(nibName: "PaymentOrderingView", bundle: nil)
//        nextVC.paymentDelegate = self;
//        nextVC.amountSTR = "\(totalPayableAmount)"
//        nextVC.StudentName = self.studentName
//        orderIdStr = "NASDUBAI-MUSIC\(Int(Date().timeIntervalSince1970))"
//        nextVC.timeStampStr = orderIdStr
//        nextVC.modalPresentationStyle = .fullScreen;
//        self.present(nextVC, animated: true)
    }
}

//MARK: - TableView Delegate, DataSource
extension MusicCartSummaryVC: UITableViewDelegate, UITableViewDataSource {
    
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
        cell.subValue1Label.text = obj.total_amount + " " + obj.currency
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

//MARK: - PaymentOrderDelegate
//extension MusicCartSummaryVC: paymentOrderDelegate {
//    func paymentStatus(status: String) {
//        if status == "Success" {
//            self.paymentSuccessCall()
//        }else if status == "Failed"{
//            AppDelegate.showSingleButtonAlert("Payment Failed", "Your Payment could not be completed.", 0)
//        } else if status == "Aborted" {
//            AppDelegate.showSingleButtonAlert("Payment Aborted", "You cancelled the payment request. You can try again!", 0)
//        }
//    }
//}

//MARK: - API Call - Get Summary Data
extension MusicCartSummaryVC {
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
        self.totalAmountLabel.text = "\(self.totalPayableAmount) AED"
    }
    
    func callInstrumentCartSummaryAPI(studentId:String) {
        self.activityIndicatior.startAnimating()
        
    }
}

//MARK: - API Call - Payment Success
extension MusicCartSummaryVC {
    private func getCardIDArrayString() -> String {
        var terms: String = ""
        var arrayOfIds : [Int] = []
        for (_, obj) in orderSummaryListData.enumerated() {
            for (_, orderObj) in obj.order_data.enumerated() {
                arrayOfIds.append(orderObj.order_id)
            }
        }
        for (indexV, obj) in arrayOfIds.enumerated() {
            if indexV == 0 {
                terms = "[\(obj)"
            }else {
                terms = "\(terms) \(obj)"
            }
            if indexV != arrayOfIds.count - 1 {
                terms = "\(terms),"
            }
        }
        terms = "\(terms)]"
        return terms
    }
    private func paymentSuccessCall() {
        self.activityIndicatior.startAnimating()
        guard orderIdStr != "" else { return }
        let cartIDsArray = self.getCardIDArrayString()
        guard !cartIDsArray.isEmpty else { return }
       
    }
}
