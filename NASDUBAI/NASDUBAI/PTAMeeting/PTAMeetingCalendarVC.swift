//
//  PTAMeetingCalendarVC.swift
//  BISAD
//
//  Created by Amritha on 24/11/22.
//

import UIKit
//import FSCalendar
import Alamofire
import SwiftyJSON


class PTAMeetingCalendarVC: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance  {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var calendarTitleLbl: UILabel!
    @IBOutlet weak var CalendarViewObj: UIView!
    @IBOutlet weak var backwardImgView: UIImageView!
    @IBOutlet weak var forwardImgView: UIImageView!
    
    
    @IBOutlet weak var leftArrow: UIButton!
    

    @IBOutlet weak var rightArrow: UIButton!
    
    
    
    
    
    var presentdays = [""]
    var studentId = ""
    var staffId = ""
    var day = ""
    var stdClass = ""
    var stdName = ""
    var staffName = ""
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        print("adaysArr:\(presentdays)")
     
        //presentdays = []
        if presentdays.count == 0 {
            alertMessage.value = "No dates are available"
        }
        //addRevealToSelf()
        calendarView.appearance.headerMinimumDissolvedAlpha = 0
        calendarView.appearance.headerTitleColor = .white
        //self.calendar.calendarHeaderView.backgroundColor = UIColor.blue
        calendarView.appearance.calendar.calendarHeaderView.backgroundColor = .appThemeColor()
        calendarView.placeholderType = .none
        calendarView.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesUpperCase
        self.calendarView.firstWeekday = 2
        let weekDayLabel =  calendarView.calendarWeekdayView.weekdayLabels
        for weekDay in weekDayLabel { weekDay.textColor = UIColor.black
        }
        
    }
    
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    
    @IBAction func leftBtnAction(_ sender: Any) {
        
        
        self.calendarView.setCurrentPage(self.gregorian.date(byAdding: .month, value: -1, to: self.calendarView.currentPage)!, animated: true)
        
    }
    
    
    
    
    
    @IBAction func rightButtonAction(_ sender: Any) {
        self.calendarView.setCurrentPage(self.gregorian.date(byAdding: .month, value: +1, to: self.calendarView.currentPage)!, animated: true)
        
        
        
    }
    
    
    
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        pushToHome()
    }
    
    
    
    
    
    
func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance,  fillDefaultColorFor date: Date) -> UIColor? {
         
    let datestring2 : String = dateFormatter1.string(from:date)
   
    if presentdays.contains(datestring2)
    {
        return UIColor.red
        
    }
    else{
        return nil
    }
    
    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance,  titleDefaultColorFor date: Date) -> UIColor? {
             
        let datestring2 : String = dateFormatter1.string(from:date)
       
        if presentdays.contains(datestring2)
        {
            return UIColor.white
            
        }
        else{
            return nil
        }
        
        }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {

        let datestring2 : String = dateFormatter1.string(from:date)
        if presentdays.contains(datestring2)
        {
            return UIColor.red
        }
        else{
            return UIColor.white
        }
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {

        let datestring2 : String = dateFormatter1.string(from:date)
        if presentdays.contains(datestring2)
        {
            return nil
            
        }
        else{
            return .black
        }
    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        
        
        if date .compare(Date()) == .orderedAscending {
            
          //  return false
            
            let currntDate = Date.getCurrentDateNew()
            var flagStatusIsThere = false
            for(_, value) in presentdays.enumerated() {
                if value == currntDate { flagStatusIsThere = true }
            }

            if flagStatusIsThere == true{

                return true

            }else{

                return false

            }
            
           
        }else {
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let caldate = dateFormatter.string(from: date)
            print("CalDate:\(caldate)")
            
            var flagStatusIsThere = false
            for(_, value) in presentdays.enumerated() {
                if value == caldate { flagStatusIsThere = true }
            }
            
            if flagStatusIsThere == true {
               
                return true
                
            }else{
                
                return false
            }
            
            
//            print("OtherDay")
//            return true
        }
    }
    
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
     
        print("calendar did select date \(date)")
                let newDate = date
                //let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let yearString = dateFormatter.string(from: newDate)
               print(yearString)
        dateFormatter.dateFormat = "dd-MM-YYYY"
        let newYearString = dateFormatter.string(from: newDate)
        print(newYearString)
        
        let stryBrd = UIStoryboard(name: "ParentsMeetingStoryboard", bundle: nil)
        let vc = stryBrd.instantiateViewController(withIdentifier: "PTMeetingAllotVC") as! PTMeetingAllotVC
        vc.studentId = studentId
        vc.staffId = staffId
        vc.date = yearString
        vc.stdClass = stdClass
        vc.stdName = stdName
        vc.staffName = staffName
        vc.titleDate = newYearString
        navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
   
}









