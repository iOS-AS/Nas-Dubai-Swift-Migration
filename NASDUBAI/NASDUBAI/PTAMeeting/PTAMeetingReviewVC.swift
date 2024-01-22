//
//  PTMeetingReviewVC.swift
//  BISAD
//
//  Created by Amritha on 25/11/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import EventKit
import EventKitUI
import SafariServices


class PTMeetingReviewVC: UIViewController {
  
    var dataArray = [PTAReviewListArray]()
    var ptaReviewModel = PtaReviewModel()
    var ptaConfirmmodel = PtaConfirmModel()
    var dataSubmitArray = [Int]()
    var dataSubmitArrayTwo = [Int]()
    var finalData : String?
    var flagVlue : String?
    var indexVal : Int?
    var strtTimeVal : String?
    var strtAmVal : String?
    var endTimeVal : String?
    var endAmVal : String?
    var calstartDate : String?
    var calEndDate : String?
    var calUrlvalue : String?
    
    
    let eventStore = EKEventStore()
    private let tagForAllConfirmAlert: Int = 500
    
    @IBOutlet weak var confirmBttn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataa()
    }
    
    func dataSubmit(){
        guard dataArray.count > 0 else { return }
        guard let indexValueTemp = indexVal else { return }
        guard dataArray.count > indexValueTemp else { return }
        guard let slotID = dataArray[indexValueTemp].id else { return }
        let passValue = "[\(slotID)]"
        self.submitAPICall(passValue: passValue)
    }
    
    func submitAPICall(passValue: String) {
        let message = ptaConfirmmodel.sumitPtaConfirm(dataValue: passValue) { [self] (m, status) in
            
            DispatchQueue.main.async {
                if status {
                    self.getDataa()
//                    self.navigationController?.popViewController(animated: false)
                    alertMessage.value = m
                } else {
                    self.presentSingleBtnAlert(message: m)
                }
            }
        }
        
//        let statValue = DefaultsWrapper().getStatusTypePTA()
//
//        if statValue == "" {
//
//                self.showAlerts(message: "Successfully confirmed appointment")
//                finalData = ""
//                dataSubmitArray.removeAll()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.getDataa()
//            }
//
//
//        }else{
//
//          showAlerts(message: "Error Occured")
//
//        }
      
//        if message != "" {
//            presentSingleBtnAlert(message: message)
//        }
    }
    
    
    func dataSubmittedForCancel(){
        guard dataArray.count > 0 else { return }
        guard let indexValueTemp = indexVal else { return }
        guard dataArray.count > indexValueTemp else { return }
        guard let studentId = dataArray[indexValueTemp].studentID else { return }
        guard let slotID = dataArray[indexValueTemp].ptaTimeSlotID else { return }
        guard let staffID = dataArray[indexValueTemp].staffID else { return }
        let message = ptaConfirmmodel.canceltPtaConfirm(studentId, slotID, "\(staffID)") { [self] (m, status) in
            if status {
                DispatchQueue.main.async {
                    self.presentSingleBtnAlert(message: m)
                }
                self.getDataa()
            }
        }
        /*
         
        
        let statValue = DefaultsWrapper().getStatusTypePTA()
        
        if statValue == "303"{
            
            showAlerts(message: "Successfully cancelled appointment")
            finalData = ""
            dataSubmitArray.removeAll()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.getDataa()
            }
            
            
        }else{
            
            showAlerts(message: "Error Occured")
            
        }
        
        if message != "" {
            presentSingleBtnAlert(message: message)
        }
         */
    }
    
    
    func getDataa(){
        
        dataArray.removeAll()
        dataSubmitArrayTwo.removeAll()
        
        if !ApiServices().checkReachability() {
            return
        }
        let url = baseUrl + "pta-review-list"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            let (val, err) = ptaReviewModel.processData(data: CF.processResponse(response, decodingType: PtaReviewList.self))
            if let e = err {
                if e == .tokenExpired {
                    ApiServices().getAccessToken {
                        self.getDataa()
                    }
                }
            } else if let v = val {
                
                UIApplication.topMostViewController?.view.stopActivityIndicator()
                print(v.data ?? "")
                dataArray.append(contentsOf: v.data ?? [])
                
                var flagStatusIsThere = false
                for(_, value) in dataArray.enumerated() {
                    if value.status == 2 && value.bookingOpen == "y"{
                        dataSubmitArrayTwo.append(value.id ?? 0)
                        flagStatusIsThere = true }
                }
                
                if dataSubmitArrayTwo.count > 0 {
                    confirmBttn.isHidden = false
                }else{
                    confirmBttn.isHidden = true
                }
                
                if dataArray.count == 0{
                    
                    showAlerts(message: "No Appointments Available")
                }
                
                tableView.reloadData()
                view.stopActivityIndicator()
                
            }
        }
        
    }
    
    
    @IBAction func AllConfirmBttnAction(_ sender: Any) {
        
        print("idArr:\(dataSubmitArrayTwo)")
        let dictNew = ["pta_time_slot_booking_ids" : "\(dataSubmitArrayTwo)"]
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(dictNew) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {

                finalData = jsonString
                print("FinalData:\(jsonString)")
            }
        }
        presentDoubleBtnAlert(self, message: "Do you want to confirm", tag: tagForAllConfirmAlert)
    }
    
}


extension PTMeetingReviewVC : UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewFinalCell", for: indexPath) as! ReviewFinalCell
        cell.name.text = "Student :" +  (dataArray[indexPath.row].student ?? "")
        cell.sclass.text = "Class :" + (dataArray[indexPath.row].studentClass ?? "")
        cell.staff.text = "Staff :" + (dataArray[indexPath.row].staff ?? "")
        cell.indexValue = indexPath.row
        let imageUrl = dataArray[indexPath.row].studentPhoto
        let endDate = dataArray[indexPath.row].bookEndDate ?? ""
        let resDate = dataArray[indexPath.row].date ?? ""
        let endTime = dataArray[indexPath.row].endTime ?? ""
        let startTime = dataArray[indexPath.row].startTime ?? ""
        
        let sTime = startTime.dropLast(3)
        let eTime = endTime.dropLast(3)
        
        var strTime : String!
        var strAm : String!
        var enTime : String!
        var endAm : String!
        
        
        if let time = startTime.getFormattedDate(currentFomat: DateFormatterType.HH_mm_ss, expectedFromat: DateFormatterType.hh_mm_a) {
            strTime = String(time.prefix(5))
            strAm  = String(time.suffix(2))
            
        }

        if let time = endTime.getFormattedDate(currentFomat: DateFormatterType.HH_mm_ss, expectedFromat: DateFormatterType.hh_mm_a) {
            enTime = String(time.prefix(5))
            endAm = String(time.suffix(2))
        }
        
        
        let dateStr =  Helper.changeDateFormat(dateString: endDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd-MMM-yyyy hh:mm:ss aa")
        let resDateStr =  Helper.changeDateFormat(dateString: resDate, fromFormat: "yyyy-MM-dd", toFormat: "dd-MMM-yyyy")
        let resrString = "Reserved date and time :" + (resDateStr ?? "") + " "
        
        cell.confirmCancellation.text = "Confirm/Cancellation closes at" + " " + (dateStr ?? "")
        cell.reservedDate.text = resrString + strTime + " " + strAm + "-" + enTime + " " + endAm
        cell.studentImage.layer.borderWidth = 1.0
        cell.studentImage.layer.masksToBounds = false
        cell.studentImage.layer.borderColor = UIColor.appThemeColor().cgColor
        cell.studentImage.layer.cornerRadius = cell.studentImage.frame.size.width/2
        cell.studentImage.clipsToBounds = true
        
        if imageUrl == ""{
            
            cell.studentImage.image = UIImage(named: "teacherIcon.png")
            
        }else{
            
            cell.studentImage.sd_setImage(with: URL(string: imageUrl ?? ""))
            
        }
        
   
      
        cell.vpnView.isHidden = true
//        if dataArray[indexPath.row].vpml != "" {
//            cell.VpnLink.isHidden = false
//            cell.VpnLink.setTitle("Click here For VPM Link", for: .normal)
//            cell.vpnView.isHidden = false
//        }else {
//            cell.vpnView.isHidden = true
//        }
        
        
        if dataArray[indexPath.row].status == 3 && dataArray[indexPath.row].bookingOpen == "y" {
            cell.confirmImageView.image = UIImage(named: "calendarAddingPta")
            cell.statusImageView.image = UIImage(named: "confirmedPta")
            cell.ptaCancelImg.alpha = 1
//            cell.vpnView.isHidden = false
            if dataArray[indexPath.row].vpml != "" {
                cell.VpnLink.isHidden = false
                cell.VpnLink.setTitle("Click here For VPM Link", for: .normal)
                cell.vpnView.isHidden = false
            }else {
                cell.vpnView.isHidden = true
            }
            print("cancel, addtocalendar")
        }
        else  if dataArray[indexPath.row].status == 2 && dataArray[indexPath.row].bookingOpen == "y" {
           // cell.AddToCalendar.text = "Confirm"
            cell.confirmImageView.image = UIImage(named: "confirm")
            cell.statusImageView.image = UIImage(named: "pendingPta")
            cell.ptaCancelImg.alpha = 1
            cell.vpnView.isHidden = true
            print("confirm, cancel")
        }
        else  if dataArray[indexPath.row].status == 3 && dataArray[indexPath.row].bookingOpen == "n" {
            print("addToCalendar, cancel")
            cell.ptaCancelImg.alpha = 0.4
            cell.vpnView.isHidden = false
            if dataArray[indexPath.row].vpml != "" {
                cell.VpnLink.isHidden = false
                cell.VpnLink.setTitle("Click here For VPM Link", for: .normal)
                cell.vpnView.isHidden = false
            }else {
                cell.vpnView.isHidden = true
            }
          
        }
        else  if dataArray[indexPath.row].status == 2 && dataArray[indexPath.row].bookingOpen == "n" {
            print(indexPath.row)
           // cell.AddToCalendar.text = "Confirm"
            cell.confirmImageView.image = UIImage(named: "confirm")
            cell.ptaCancelImg.alpha = 0.4
            cell.vpnView.isHidden = true
            print("confirm, cancel")
        }

        cell.onSubmitAction = self.actionOfSubmit
        cell.onCancelAction = self.CancelAction
        cell.onVpmlAction = self.actionOfVpml
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    fileprivate func actionOfSubmit(_ indexValue: Int) {
        
        let statVal = dataArray[indexValue].status
        if statVal == 3 {
            calstartDate = dataArray[indexValue].date
            calEndDate = dataArray[indexValue].bookEndDate
            calUrlvalue = dataArray[indexValue].vpml
            
            addEventToCalendar()
            print("Date Add To Calendar")
            
        }else{
            
            presentDoubleBtnAlert(self, message: "Do you want to confirm")
            flagVlue = "Confirm"
            indexVal = indexValue
            print("Button Action \(indexValue)")
            
        }
    }
    
    
    
    fileprivate func CancelAction(_ indexValue: Int) {
        
        print("Indexvalue: \(indexValue)")
        
        let statVal = dataArray[indexValue].status
        let openVal = dataArray[indexValue].bookingOpen
        if statVal == 3 && openVal == "n" || statVal == 2 && openVal == "n" {
            
            
        }else{
            
            presentDoubleBtnAlert(self, message: "Do you want to cancel appointment?")
            indexVal = indexValue
            flagVlue = "Cancel"
            
        }
    }

    fileprivate func actionOfVpml(_ indexValue: Int) {
        print("Indexvalue: \(indexValue)")
        
        guard indexValue < dataArray.count else {
            // Handle the case where the index is out of range.
            return
        }
        let linkValue = dataArray[indexValue].vpml ?? ""

        if let encodedLink = linkValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: encodedLink) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                // Handle the case where the URL cannot be opened.
                showAlerts(message: "Cannot open the link")
            }
        } else {
            // Handle the case where the URL is not valid.
            showAlerts(message: "Invalid link format")
        }
    }
    
    func addEventToCalendar() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startD = dateFormatter.date(from:calstartDate ?? "")
        let endD = dateFormatter.date(from:calEndDate ?? "")
        
        eventStore.requestAccess( to: EKEntityType.event, completion:{(granted, error) in
            DispatchQueue.main.async {
                if (granted) && (error == nil) {
                    let event = EKEvent(eventStore: self.eventStore)
                    event.title = "PARENT MEETING"
                    event.startDate = startD
                    event.endDate = startD
                    event.notes = self.calUrlvalue
                    let eventController = EKEventEditViewController()
                    eventController.event = event
                    eventController.eventStore = self.eventStore
                    eventController.editViewDelegate = self
                    self.present(eventController, animated: true, completion: nil)
                    
                }
            }
            
            
        })
    }
        
}

//MARK: - Action
extension PTMeetingReviewVC {
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        pushToHome()
    }

}


extension PTMeetingReviewVC: DCBaseDelegate {
    func showAlerts(message: String) {
        presentSingleBtnAlert(message: message)
    }
}

extension PTMeetingReviewVC: DoubleBtnAlertDelegate {
    func submitAllToConfirm() {
        guard dataSubmitArrayTwo.count > 0 else { return }
        var passValue = "["
        for (indexValue, value) in self.dataSubmitArrayTwo.enumerated() {
            if indexValue == self.dataSubmitArrayTwo.count - 1 {
                passValue = "\(passValue)\(value)]"
            }else {
                passValue = "\(passValue)\(value),"
            }
        }
        self.submitAPICall(passValue: passValue)
    }
    func okPressed(tag: Int) {
        if tag == tagForAllConfirmAlert {
            self.submitAllToConfirm()
            return
        }
        if flagVlue == "Confirm"{
            let statValue = dataArray[indexVal ?? 0].status
            if statValue == 3 {
            }else{
                callConfirm()
            }
            
            func callConfirm(){
                
                let idValue = (dataArray[indexVal ?? 0].id)!
                dataSubmitArray.append(idValue)
                let dictNew = ["ids" : "\(dataSubmitArray)"]
                let encoder = JSONEncoder()
                if let jsonData = try? encoder.encode(dictNew) {
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        
                        finalData = jsonString
                        print("FinalData:\(jsonString)")
                    }
                }
                dataSubmit()
            }
            print("ConfirmOk")
            
        }else{
            let statValue = dataArray[indexVal ?? 0].status
            let openVal = dataArray[indexVal ?? 0].bookingOpen
            if statValue == 3{
                if openVal == "y"{
                    callCancel()
                }else{
                    
                }
            }else{
                callCancel()
            }
            
            func callCancel(){
                
                let idValue = (dataArray[indexVal ?? 0].id)!
                dataSubmitArray.append(idValue)
                let dictNew = ["pta_time_slot_booking_ids" : "\(dataSubmitArray)"]
                let encoder = JSONEncoder()
                if let jsonData = try? encoder.encode(dictNew) {
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        
                        finalData = jsonString
                        print("FinalData:\(jsonString)")
                    }
                }
                dataSubmittedForCancel()
                
            }
            print("CancelOk")
        }
    }
}


extension PTMeetingReviewVC: EKEventEditViewDelegate {

    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}
