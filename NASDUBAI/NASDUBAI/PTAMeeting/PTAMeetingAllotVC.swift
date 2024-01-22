//
//  PTMeetingAllotVC.swift
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

class PTMeetingAllotVC: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cancelLbl: UILabel!
    @IBOutlet weak var reviewConfirmLbl: UILabel!
    @IBOutlet weak var aboutImgView: UIImageView!
    
    @IBOutlet weak var tdate: UILabel!
    
    @IBOutlet weak var infoIconObj: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studClass: UILabel!
    @IBOutlet weak var stafName: UILabel!
    var flag = 0
    var studentId = ""
    var staffId = ""
    var date = ""
    var stdClass = ""
    var stdName = ""
    var staffName = ""
    var titleDate = ""
    var dateValue = ""
    var vpmlValue = ""
    var roomvalue = ""
    var startTime = ""
    var endTime = ""
    var bookDate = ""
    var slotID : Int = 0
    
    
    let val: Int! = nil
    
    @IBOutlet weak var todayDate: UILabel!
    
    var ptaTimeSlotModel = PtaTimeSlotModel()
    var dataArray = [PtaTimeSlotResponseDataArray]()
    var ptaAllotModel = PTMeetingAllotModel()
    var ptaTimeSlot: PtaTimeSlot?
    
    var slotBookedArray: [PtaTimeSlotResponseDataArray] = []
    
    @IBOutlet weak var vpnView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("TitleLabel:\(titleDate)")
        
        let dateFormatterNew = DateFormatter()
        dateFormatterNew.dateFormat = "dd-MM-yyyy"
        let dateNew = dateFormatterNew.date(from:titleDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let yearString = dateFormatter.string(from: dateNew)
        
        todayDate.text = yearString
        studentName.text = "Student:  \(stdName)"
        studClass.text = "Class: \(stdClass)"
        stafName.text = "Staff:  \(staffName)"
        
        cancelLbl.isHidden = true
        reviewConfirmLbl.isHidden = true
        vpnView.isHidden = true
        
        print("StudId:\(studentId)")
        print("StaffId:\(staffId)")
        
        print(stdClass)
        //     getDataa()
        for each in [cancelLbl, aboutImgView, reviewConfirmLbl, infoIconObj] {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelPressed))
            tapGesture.numberOfTouchesRequired = 1
            each?.addGestureRecognizer(tapGesture)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            print(stdClass)
            getDataa()
    }
    
    @objc func labelPressed(_ sender: UITapGestureRecognizer?) {
        
        if sender?.view == cancelLbl {
            
            cancelData()
            print("cancel label clicked")
            
        }else if sender?.view == aboutImgView {
            print("aboutImgView clicked")
        }else if sender?.view == reviewConfirmLbl {
            
            let stryBrd = UIStoryboard(name: "ParentsMeetingStoryboard", bundle: nil)
            let vc = stryBrd.instantiateViewController(withIdentifier: "PTMeetingReviewVC") as! PTMeetingReviewVC
            navigationController?.pushViewController(vc, animated: true)
        }else if sender?.view == infoIconObj {
            
            print("informationIcon")
            showAlerts()
            
            presentPTAIbuttonTableView(message: "",dataArray: dataArray)
            //            let vc = storyboard?.instantiateViewController(withIdentifier: "PtaMeetingIButton") as! PtaMeetingIButton
            //            navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
        
    }
    
    func cancelData(){
        
        flag = 0
        presentDoubleBtnAlert(self, message: "Do you want to cancel this appointment ?")
    }
    
    func getDataa(){
        
        dataArray.removeAll()
        
        if !ApiServices().checkReachability() {
            return
        }
        let url = baseUrl + "pta-list"
        let parameters: Parameters = ["student_id": studentId, "staff_id": staffId, "date": date]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            let (val, err) = ptaTimeSlotModel.processData(data: CF.processResponse(response, decodingType: PtaTimeSlot.self))
            if let e = err {
                if e == .tokenExpired {
                    ApiServices().getAccessToken {
                        self.getDataa()
                    }
                }
            } else if let v = val {
                
                UIApplication.topMostViewController?.view.stopActivityIndicator()
                dataArray.append(contentsOf: v.data ?? [])
                slotID = 0
                var flagStatusIsThere = false
                for(_, value) in dataArray.enumerated() {
                    if value.status == 2 {
                        flagStatusIsThere = true
                        self.slotID = value.slotID ?? 0
                    }
                    if value.status == 3 {
                        vpmlValue = value.vpml ?? ""
                        /// Client asked to remove vpnView in review page
                        if vpmlValue != "" {
                            vpnView.isHidden = false
                        }else {
                            vpnView.isHidden = true
                        }
                    }
                }
                
                if flagStatusIsThere == true{
                    
                    cancelLbl.isHidden = false
                    reviewConfirmLbl.isHidden = false
                }else{
                    
                    cancelLbl.isHidden = true
                    reviewConfirmLbl.isHidden = true
                }
                UIApplication.topMostViewController?.view.stopActivityIndicator()
                print(dataArray)
                collectionView.reloadData()
                //dataArray.append(contentsOf: v.response?.data ?? [])
                view.stopActivityIndicator()
                
            }
        }
        
    }
    
    fileprivate func actionOfVpml() {

        if let encodedLink = vpmlValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: encodedLink) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                // Handle the case where the URL cannot be opened.
                presentSingleBtnAlert(message: "Cannot open the link")
            }
        } else {
            // Handle the case where the URL is not valid.
            presentSingleBtnAlert(message: "Invalid link format")
        }
    }
    
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        pushToHome()
    }
    
    @IBAction func onVpmlAction(_ sender: Any) {
        actionOfVpml()
    }
    
    
}

extension PTMeetingAllotVC: UICollectionViewDelegate, UICollectionViewDataSource {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = dataArray[indexPath.row]
        
        dateValue = dataArray[indexPath.row].meetingDate ?? ""
        vpmlValue = dataArray[indexPath.row].vpml ?? ""
        roomvalue = dataArray[indexPath.row].room ?? ""
        startTime = dataArray[indexPath.row].slotStartTime ?? ""
        endTime = dataArray [indexPath.row].slotEndTime ?? ""
        bookDate = dataArray[indexPath.row].bookingEndDate ?? ""
        slotID = dataArray[indexPath.row].slotID ?? 0
        
        var flagStatusIsThere = false
        for(_, value) in dataArray.enumerated() {
            if value.status == 2 { flagStatusIsThere = true }
        }
        
        var flagStatusIsThereNew = "notfound"
        for(_, value) in dataArray.enumerated() {
            if value.status == 3 {
                vpmlValue = value.vpml ?? ""
                ///Client asked to remove vpnView in review page
                if vpmlValue != "" {
                    vpnView.isHidden = false
                }else {
                    vpnView.isHidden = true
                }
                flagStatusIsThereNew = "found" }
        }
        if flagStatusIsThere == false {
            
            if flagStatusIsThereNew == "notfound" {
                
                if item.status == 0 && item.bookingStatus == "y"{
                    flag = 1
                    let dateFormatterNew = DateFormatter()
                    dateFormatterNew.dateFormat = "dd-MM-yyyy"
                    let dateNew = dateFormatterNew.date(from:titleDate)!
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MMM-yyyy"
                    let yearString = dateFormatter.string(from: dateNew)
                    guard let time = startTime.getFormattedDate(currentFomat: DateFormatterType.HH_mm_ss, expectedFromat: DateFormatterType.hh_mm_a)
                    else {
                        return
                    }
                    
                    guard let eetime = endTime.getFormattedDate(currentFomat: DateFormatterType.HH_mm_ss, expectedFromat: DateFormatterType.hh_mm_a)
                    else {
                        return
                    }
                    
                    
                    presentDoubleBtnAlert(self, message: "Do you want to reserve your appointment on \(yearString), \(time) to \(eetime)")
                }
                
                else if item.status == 0 && item.bookingStatus == "n"{
                    
                    alertMessage.value = "Booking and cancellation date is over"
                    
                }else if item.status == 1 {
                    
                    alertMessage.value = "Not Available"
                    
                }else if item.status == 2 {
                    
                    alertMessage.value = "This slot is Reserved"
                    
                } else {
                    
                    alertMessage.value = "These slot are alredy booked"
                    
                }
            }
            
        }else{
            
            print("Status:\(item.status)")
            print("BookingStat:\(item.bookingStatus)")
            if  item.status == 0 && item.bookingStatus == "y" || item.status == 2 && item.bookingStatus == "y"    {
                
                if item.status == 2 && item.bookingStatus == "y" {
                    presentSingleBtnAlert(message: "This slot is reserved by you for the Parents Meeting. Click 'Cancel' option to cancel this appointment")
                }else if flagStatusIsThere && item.status == 0 {
                    presentSingleBtnAlert(message: "Another Slot is already booked by you. If you want to take appointment on this time, please cancel earlier appointment and try")
                }else {
                    flag = 1
                    presentDoubleBtnAlert(self, message: "Do you want to reserve your appointment on \(titleDate), \(startTime) - \(endTime)")
                    
                }
            }
            
            else{
                
                alertMessage.value = "Booking and cancellation date is over"
                presentSingleBtnAlert(message: alertMessage.value)
            }
            
            // alertMessage.value = "Slot are alrdy reserved... "
        }
        
        if flagStatusIsThereNew == "notfound"{
            
        }else{
            
            alertMessage.value = "Your time slot is already confirmed"
        }
        
    }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PTMTimeSlotCell", for: indexPath) as? PTMTimeSlotCell {
                cell.layer.masksToBounds = true
                cell.layer.cornerRadius = 5
                let item = dataArray[indexPath.row]
                if item.status == 0 {
                    cell.backgroundColor = .white
                } else if item.status == 1 {
                    cell.backgroundColor = .gray
                }else if item.status == 2 {
                    
                    dateValue = dataArray[indexPath.row].meetingDate ?? ""
                    vpmlValue = dataArray[indexPath.row].vpml ?? ""
                    roomvalue = dataArray[indexPath.row].room ?? ""
                    startTime = dataArray[indexPath.row].slotStartTime ?? ""
                    endTime = dataArray [indexPath.row].slotEndTime ?? ""
                    bookDate = dataArray[indexPath.row].bookingEndDate ?? ""
                    print("DataValue:\(bookDate)")
                    cell.backgroundColor = .appThemeColor()
                    
                } else {
                    cell.backgroundColor = .secondaryColor()
                    cell.fromAmPMLbl.textColor = .white
                    cell.fromTimeLbl.textColor = .white
                    cell.toTimeLbl.textColor = .white
                    cell.toAmPMLbl.textColor = .white
                    // cell.backgroundColor = .ptaCellColour()
                }
                
                let startTime = dataArray[indexPath.row].slotStartTime
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                var timeFromDate = dateFormatter.date(from: startTime!)
                print("StartTime:\(startTime)")
                
                var startTimee = dataArray[indexPath.row].slotStartTime ?? ""
                var endTime = dataArray[indexPath.row].slotEndTime ?? ""
                
                let sTime = String(startTimee.dropLast(3))
                let eTime = String(endTime.dropLast(3))
                
                
                cell.setBlueBorder()
                
                
                if let time = startTime?.getFormattedDate(currentFomat: DateFormatterType.HH_mm_ss, expectedFromat: DateFormatterType.hh_mm_a) {
                    cell.fromTimeLbl.text = String(time.prefix(5))
                    cell.fromAmPMLbl.text = String(time.suffix(2))
                }
                
                if let time = endTime.getFormattedDate(currentFomat: DateFormatterType.HH_mm_ss, expectedFromat: DateFormatterType.hh_mm_a) {
                    cell.toTimeLbl.text = String(time.prefix(5))
                    cell.toAmPMLbl.text = String(time.suffix(2))
                }
                
                
                return cell
            }
            return UICollectionViewCell()
        }
    }


extension PTMeetingAllotVC : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
     
        let numberOfItemPerRow:CGFloat = 4.00
        let spacing:CGFloat = (15)
        
        let availableWidth = width - (spacing * (numberOfItemPerRow + 1))
        
        let itemDimension = CGFloat(availableWidth/numberOfItemPerRow)
       
        return CGSize(width: itemDimension, height: itemDimension/1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        _ = collectionView.bounds.width
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        _ = collectionView.bounds.width
        return 15
    }
    
}


extension PTMeetingAllotVC: DoubleBtnAlertDelegate {
    
    func okPressed(tag: Int) {
        
        if flag == 0 {
            print("BookDate:\(bookDate)")
            let message = ptaAllotModel.cancelData(studentID: studentId, ptaTimeSlotID: slotID, staffId: staffId) { [self] (m, status) in
                DispatchQueue.main.async {
                    if status {
                        self.getDataa()
                        // navigationController?.popViewController(animated: false)
                        alertMessage.value = "Request cancelled successfully."
//                        self.presentSingleBtnAlert(message: m)
                    } else {
                        self.presentSingleBtnAlert(message: m)
                    }
                }
            }
            if message != "" {
                presentSingleBtnAlert(message: message)
            }
            
        }
        else {
            
            // alertMessage.value = "Reserved only - please review and confirm booking"
            let message = ptaAllotModel.SubmitData(studentID: studentId, ptaTimeSlotID: slotID, staffId: staffId) { [self] (m, status) in
                DispatchQueue.main.async {
                    if status {
                        
                        self.getDataa()
                        // navigationController?.popViewController(animated: false)
                        alertMessage.value = "Reserved only - please review and confirm booking"
                        
                    } else {
                        self.presentSingleBtnAlert(message: m)
                    }
                }
            }
            if message != "" {
                presentSingleBtnAlert(message: message)
            }
            
            //flag = 0
        }
        
    }
    
    
}


