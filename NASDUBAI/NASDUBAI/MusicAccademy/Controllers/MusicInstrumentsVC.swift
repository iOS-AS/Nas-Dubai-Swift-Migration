//
//  MusicInstrumentsVC.swift
//  NAS
//
//  Created by FAO on 12/08/23.
//  Copyright © 2023 AJITH. All rights reserved.
//

import UIKit

class MusicInstrumentsVC: UIViewController {
    
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    @IBOutlet weak var plansListTableView: UITableView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var studId: String!
    var dataObj: InstrumentListData?
    var managerDataObj: InstrumentListData!
    var instrumentSelected: String = ""
    var submitAndCallAPI: () -> () = { }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.managerDataObj = dataObj
        self.initUI()
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        if notification.name.rawValue ==  "SingleButtonAlertNotification" {
            if notification.object as? String == "submitCartMusic" {
                self.navigationController?.popViewController(animated: true)
                self.submitAndCallAPI()
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("SingleButtonAlertNotification"), object: nil)
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        var learning_level = "1"
        if dataObj?.allLessonAlreadyPurcasedSucceded == true {
            self.showAlertForAllLessonAlreadySelected()
            return
        }
        if yesButton.isSelected || noButton.isSelected {
            if yesButton.isSelected {
                learning_level = "0"
            }
        }else {
            
           // AppDelegate.showSingleButtonAlert("Alert", "Please select your child's learning level", 0)
            return
        }
        
        if self.getSelectedTermsArray().count == 0 {
            //AppDelegate.showSingleButtonAlert("Alert", "Please select a class", 0)
            return
        }
        let vc = MusicConsentVC(nibName: "MusicConsentVC", bundle: nil)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        vc.onSubmit = { [weak self] instrumentConsentStatus in
            self?.callSubmitCart(instrumentConsentStatus: "\(instrumentConsentStatus)", learning_level: learning_level)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func yesButtonTapped() {
        yesButton.isSelected = true
        noButton.isSelected = false
    }
    
    @IBAction func noButtonTapped() {
        yesButton.isSelected = false
        noButton.isSelected = true
    }
    
    func initUI() {
        plansListTableView.delegate = self
        plansListTableView.dataSource = self
        plansListTableView.register(UINib(nibName: "PlansTableViewCell", bundle: nil), forCellReuseIdentifier: "PlansTableViewCell")
        self.plansListTableView.alwaysBounceVertical = false
        self.plansListTableView.separatorStyle = .none
        self.plansListTableView.bounces = false
        self.plansListTableView.reloadData()
        self.titleLabel.text = "\(instrumentSelected) Classes"
        self.showAlertForAllLessonAlreadySelected()
    }
    
    private func showAlertForAllLessonAlreadySelected() {
        if dataObj?.allLessonAlreadyPurcasedSucceded == true {
            //AppDelegate.showSingleButtonAlert("Alert", "You have already registered for this instrument", 0)
        }
    }
}

extension MusicInstrumentsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return managerDataObj.term_data.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .white
        let label = UILabel()
        label.frame = CGRect.init(x: 10, y: 5, width: headerView.frame.width-20, height: headerView.frame.height-10)
        label.text = managerDataObj.term_data[section].term_name
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        
        let labelNoSlotes = UILabel()
        labelNoSlotes.frame = CGRect.init(x: 10, y: 5, width: headerView.frame.width-20, height: headerView.frame.height-10)
        labelNoSlotes.font = .systemFont(ofSize: 15)
        labelNoSlotes.textColor = .darkGray
        labelNoSlotes.textAlignment = .center
        labelNoSlotes.backgroundColor = .clear
        if managerDataObj.term_data[section].remaining_slot_count == 0 {
            labelNoSlotes.text = "(No Slot Remaining)"
        }else {
            labelNoSlotes.text = ""
        }
        let viewBottom = UIView()
        viewBottom.frame = CGRect.init(x: 10, y: 28, width: headerView.frame.width-20, height: 1)
        viewBottom.backgroundColor = #colorLiteral(red: 0.2549999952, green: 0.7179999948, blue: 0.7689999938, alpha: 1)
                
        headerView.addSubview(label)
        headerView.addSubview(labelNoSlotes)
        headerView.addSubview(viewBottom)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if managerDataObj.term_data[section].allowSelectionRelatedToUI {
            return 0
        }else {
            return 30
        }
    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if managerDataObj.term_data[section].allowSelection {
//            return UIView(frame: .zero)
//        }else {
//            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
//            headerView.backgroundColor = .white
//            let label = UILabel()
//            label.numberOfLines = 2
//            label.frame = CGRect.init(x: 10, y: 5, width: headerView.frame.width-20, height: headerView.frame.height-10)
//            label.text = "Already purchased for the term."
//            label.font = .systemFont(ofSize: 13)
//            label.textColor = .darkGray
//
//            headerView.addSubview(label)
//            return headerView
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managerDataObj.term_data[section].lesson_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlansTableViewCell") as? PlansTableViewCell {
            let obj = managerDataObj.term_data[indexPath.section].lesson_data[indexPath.row]
            cell.planLabel.text = obj.name
            cell.amountLabel.text = obj.total_amount + " " + obj.currency
            if obj.course_selected {
                cell.selectionButton.setImage(UIImage(named: "checked_box.png"), for: .normal)
            }else {
                cell.selectionButton.setImage(UIImage(named: "unchecked.png"), for: .normal)
            }
            cell.selectionStyle = .none
            let colorValue = managerDataObj.term_data[indexPath.section].allowSelectionRelatedToUI ? UIColor.black : UIColor.gray
            cell.planLabel.textColor = colorValue
            cell.amountLabel.textColor = colorValue
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.managerDataObj.term_data.count > 0 else { return }
        guard self.managerDataObj.term_data.count > indexPath.section else { return }
        guard self.managerDataObj.term_data[indexPath.section].allowSelectionRelatedToUI else { return }
        guard self.managerDataObj.term_data[indexPath.section].lesson_data.count > 0 else { return }
        guard self.managerDataObj.term_data[indexPath.section].lesson_data.count > indexPath.row else { return }
        for i in 0..<self.managerDataObj.term_data[indexPath.section].lesson_data.count {
            self.managerDataObj.term_data[indexPath.section].lesson_data[i].course_selected = false
        }
        self.managerDataObj.term_data[indexPath.section].lesson_data[indexPath.row].course_selected = !self.managerDataObj.term_data[indexPath.section].lesson_data[indexPath.row].course_selected
        self.plansListTableView.reloadData()
    }
}

//MARK: API Call
extension MusicInstrumentsVC {
    func getSelectedTermsArray()-> [Terms] {
        var termsArray: [Terms] = []
        if let managerDataObj = managerDataObj {
            for obj in managerDataObj.term_data {
                for innerObj in obj.lesson_data {
                    if innerObj.course_selected && innerObj.id != -1 {
                        let termsObj = Terms(term_id: "\(obj.term_id)", lesson_id: innerObj.id)
                        termsArray.append(termsObj)
                    }
                }
            }
        }
        return termsArray
    }
    
    func callSubmitCart(instrumentConsentStatus: String, learning_level: String) {
        guard let instrumentID = self.dataObj?.instrument_id else { return }
        let termsArray: [Terms] = self.getSelectedTermsArray()
        var terms: String = ""
        for (indexV, obj) in termsArray.enumerated() {
            if indexV == 0 {
                terms = "[\(obj.getTermsDictInString())"
            }else {
                terms = "\(terms) \(obj.getTermsDictInString())"
            }
            if indexV != termsArray.count - 1 {
                terms = "\(terms),"
            }
        }
        terms = "\(terms)]"
        self.callCartSubmitApi(instrumentID: "\(instrumentID)", instrument_consent_status: instrumentConsentStatus, learning_level: learning_level, terms: terms)
    }
    
    func callCartSubmitApi(instrumentID: String, instrument_consent_status: String, learning_level: String, terms: String) {
        
        self.activityIndicatior.startAnimating()
       
    }
}
struct Terms {
    var term_id: String
    var lesson_id: Int
    func getTermsDictInString() -> String {
        return "{\"term_id\":\"\(term_id)\",\"lesson_id\":\(lesson_id)}"
    }
}
