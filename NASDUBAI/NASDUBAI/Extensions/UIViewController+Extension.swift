//
//  UIViewController+Extension.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 07/11/23.
//

import UIKit
//import EzPopup

let SCREEN_WIDTH = UIScreen.main.bounds.width
var alertMessage: Observable<String> = Observable("")
extension UIViewController {
    
    func addRevealToSelf<T: UIViewController>(_ parent: T? = nil) {
        let mainStoryBoard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let controller:RevealViewCV = mainStoryBoard.instantiateViewController(withIdentifier: "RevealViewCV") as! RevealViewCV
        controller.delegate = parent as? RevealDelegate
        let width = UIScreen.main.bounds.width
        print("widthValue: \(width)")
        controller.view.frame = CGRect(x: -width, y: 0, width: width, height: view.frame.height)
        self.view.addSubview(controller.view)
        self.addChild(controller)
        controller.didMove(toParent: self)

//        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(showReveal))
//        gesture.direction = .right
//        self.view.addGestureRecognizer(gesture)

        // Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(panGestureRecognizer)

        hideRevealBool.bind { (completed) in
            if completed {
                self.hideReveal()
                hideRevealBool.value = false
            }
        }
    }

    @objc func showReveal() {

        if children.count > 0 {
            //Here we are add the WebPdfViewController as childView. So we are checking that one also..
            if children[0] is RevealViewCV {
                let width = UIScreen.main.bounds.width
                UIView.animate(withDuration: 0.3) { [self] in
                    children[0].view.frame = CGRect(x: 0, y: 0, width: width, height: view.frame.height)
//                    print(children[0].view.frame.origin.x)
                }
            }
        }
    }

    @objc func hideReveal() {

        if children.count > 0 {
            //Here we are add the WebPdfViewController as childView. So we are checking that one also..
            if children[0] is RevealViewCV {
                let width = UIScreen.main.bounds.width
                UIView.animate(withDuration: 0.3) { [self] in
                    children[0].view.frame = CGRect(x: -width, y: 0, width: width, height: view.frame.height)
                }
            }
        }
    }
    func showAlerts() {
        alertMessage.bind { [self] (message) in
            if message == "" { return }
            alertMessage.value = ""
            presentSingleBtnAlert(message: message)
        }
    }
    
    func pushToVC(name:String){

        if currentVC == name {
            return hideRevealBool.value = true
        }

        switch name {
        case "Home":
            currentVC = "Home"
            pushToHome()
        case "Calendar":
            currentVC = "Calendar"
            pushToCalendar()
        case "Notifications":
            currentVC = "Notifications"
            pushToMessageList()
        case "Communications":
            currentVC = "Communications"
            pushToCommunication()
        case "Absence & Early Pickup":
            currentVC = "Absence & Early Pickup"
            UserDefaults.standard.set("Report", forKey: "KeyVal")
            pushToAbsence()
        case "Lunch Box":
            currentVC = "Lunch Box"
            pushToLunchVC()
        case "Payment":
            currentVC = "Payment"
            pushToPaymentFirstVC()
        case "Teacher Contact":
            currentVC = "Teacher Contact"
            pushToTeacherContact()
        case "Social Media":
            currentVC = "Social Media"
            pushToSocialMedia()
        case "Reports":
            currentVC = "Reports"
            pushToReports()
        case "Attendance":
            currentVC = "Attendance"
            pushToAttendance()
        case "Timetable":
            currentVC = "Timetable"
            pushToTimeTable()
        case "Forms":
            currentVC = "Forms"
            pushToForms()
        case "Staff Directory":
            currentVC = "Staff Directory"
            pushToStaffDirectoryVC()
        case "Term Dates":
            currentVC = "Term Dates"
            pushToTermDates()
        case "Curriculum":
            currentVC = "Curriculum"
            pushToCurriculum()
        case "Early Years":
            currentVC = "Early Years"
            pushToEarlyYearsVC()
        case "Primary":
            currentVC = "Primary"
            pushToPrimaryYearsVC()
        case "Secondary":
            currentVC = "Secondary"
            pushToSecondaryYearsVC()
        case "Gallery":
            currentVC = "Gallery"
            pushToGalleryVC()
        case "About Us":
            currentVC = "About Us"
            pushToAboutUs()
        case "Parents Meeting":
            
            if DefaultsWrapper().getPTAFlagValue() == false || DefaultsWrapper().getPTAFlagValue() == nil
            {
                currentVC = "Parents Meeting"
                //pushToPTATutorial()
                
            } else {
                currentVC = "Parents Meeting"
                pushToParentsMeeting()
                
                
            }
            
        case "Contact Us":
            currentVC = "Contact Us"
            pushToContactUs()
        case "Apps":
            currentVC = "Apps"
            pushToApps()
            
        case "Payments":
            currentVC = "Payments"
//           pushtoPayementVC()
            //pushToPaymentFirstVC()
            
            
        
        case "Permission Forms":
            currentVC  = "Permission Forms"
           // pushToPayementSlip()
        case "Eap", "EAP":
            currentVC  = "Eap"
            //pushToCCA()
        case "Enrichment":
            currentVC  = "Enrichment"
            //pushToCCA()
        case "Parent Essentials":
            currentVC = "Parent Essentials"
            //pushToParentEssentialsVC()
            
        default:
            currentVC = "Home"
            pushToHome()
        }
    }
    
    
    func pushToHome(updateUserDetails: Bool = false) {
        currentVC = "Home"
        let storyboardMain = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let vc = storyboardMain.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        vc.updateUserDetails = updateUserDetails
        navigationController?.pushViewController(vc, animated: !updateUserDetails)
    }
    func presentSingleBtnAlert<T: UIViewController>(_ parent: T? = nil, message: String) {
        let storyboardMain = UIStoryboard(name: "SingleButtonAlertVC", bundle: nil)
        let vc = storyboardMain.instantiateViewController(withIdentifier: "SingleButtonAlertVC") as! SingleButtonAlertVC
        vc.message = message
        vc.delegate = parent as? SingleBtnAlertDelegate
        vc.modalPresentationStyle = .overCurrentContext
        presentViewControllerFromVisibleViewController(vc, animated: false, completion: nil)

    }
    func presentDoubleBtnAlert<T: UIViewController>(_ parent: T? = nil, title: String = "Confirm?", message: String, tag: Int = 0) {
        let storyboardMain = UIStoryboard(name: "DoubleButtonAlertVC", bundle: nil)
        let vc = storyboardMain.instantiateViewController(withIdentifier: "DoubleButtonAlertVC") as! DoubleButtonAlertVC
        vc.message = message
        vc.titleStr = title
        vc.tag = tag
        vc.delegate = parent as? DoubleBtnAlertDelegate
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
    
    
    func showSignUp() {
        let storyboardMain = UIStoryboard(name: "SignUpStoryboard", bundle: nil)
        let vc = storyboardMain.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
//
    func showForgetPassword() {
        let storyboardMain = UIStoryboard(name: "ForgotPasswordVC", bundle: nil)
        let vc = storyboardMain.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
    func presentStudentSelection<T: UIViewController>(_ parent: T? = nil) {
        let storyboardMain = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let vc = storyboardMain.instantiateViewController(withIdentifier: "StudentSelectionVC") as! StudentSelectionVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = parent as? StudentDelegate
        present(vc, animated: false)
    }

    func pushToWebPdf(isPdf: Bool, pdfName: String = "", campaignID: String? = nil, url: String = "", studentName: String? = nil) {
        let storyboardMain = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let vc = storyboardMain.instantiateViewController(withIdentifier: "WebPdfVC") as! WebPdfVC
//        vc.isPdf = isPdf
//        vc.pdfName = pdfName
//        vc.campaignID = campaignID
//        vc.studentName = studentName ?? ""
//        vc.url = url
        navigationController?.pushViewController(vc, animated: true)
    }
    func pushToReports(){
        
    }
    func pushToTutorial(){
        
    }
    func pushToCalendar() {
        
    }
    func pushToAboutUs() {
//        let vc = AboutUsViewController(nibName: "AboutUsViewController", bundle: nil)
//        vc.isRevealedAdded = false
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToCCA() {
//        let vc = CCAsNewViewController(nibName: "CCAsNewViewController", bundle: nil)
//        vc.isRevealedAdded = false
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToParentsMeeting() {
       
        let storyboardMain = UIStoryboard(name: "PTMeetingStoryboard", bundle: nil)
        let vc = storyboardMain.instantiateViewController(withIdentifier: "PTAMeetingVC") as! PTAMeetingVC
        navigationController?.pushViewController(vc, animated: true)
    }
    func pushToAttendance() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "AttendanceViewController") as! AttendanceViewController
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToStaffDirectoryVC() {
      
        
//        let storyboardMain = UIStoryboard(name: "StaffDirectoryStoryboard", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "StaffDepartmentVC") as! StaffDepartmentVC
//        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func pushToEnrollmentVc() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "ReEnrollmentClass") as! ReEnrollmentClass
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func pushToPayementSlip() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "PaymentSlipVC") as! PaymentSlipVC
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func pushToEnrollmentStatus() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "EnrollmentStatusVC") as! EnrollmentStatusVC
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func pushToEmailPopUpVCReEnroll() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "EmailPopUpVCReEnroll") as! EmailPopUpVCReEnroll
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.modalTransitionStyle = .crossDissolve
//        present(vc, animated: false)
    }
    
    
    
    
//    func presentCalendarPopup<T: UIViewController>(_ parent: T? = nil, array: [CalendarPopup]) {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "CalendarPopupViewController") as! CalendarPopupViewController
//        vc.dataArray = array
//        vc.delegate = parent as! CalendarPopupDelegate
//        vc.modalPresentationStyle = .overCurrentContext
//        present(vc, animated: false)
//    }

    
    func presentUpdatePopupVC() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "UpdatePopupViewController") as! UpdatePopupViewController
//        vc.modalPresentationStyle = .overCurrentContext
//        present(vc, animated: false)
    }


   

    func presentStaffSelection<T: UIViewController>(_ parent: T? = nil, studenID: String) {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "StaffSelectionViewController") as! StaffSelectionViewController
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.delegate = parent as? StaffDelegate
//        vc.studenID = studenID
//        present(vc, animated: false)
    }


//    func presentEventPopup(event: FormattedEvent) {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "EventPopupViewController") as! EventPopupViewController
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.event = event
//        present(vc, animated: false)
   // }

    func presentEmailPopup(studentID: String, emailID: String) {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "EmailPopUpViewController") as! EmailPopUpViewController
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.studentID = studentID
//        vc.emailID = emailID
//        vc.flagValue = "Teachr"
//        present(vc, animated: false)
    }



    func pushToMessageList() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
//        vc.isRevealedAdded = false
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    //func pushToCalendarDetails(data: CalendarBaseArray) {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "CalendarDetailsViewController") as! CalendarDetailsViewController
//        vc.passedData = data
//        navigationController?.pushViewController(vc, animated: true)
   // }
    
    
//    func pushToHTML(fromMessage:Bool = false, data: NotificationModel? = nil, typeOfPage: TypeOfPage? = nil, value: Any? = nil) {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "HTMLViewController") as! HTMLViewController
//        vc.data = data
//        vc.fromMessage = fromMessage
//        vc.typeOfPage = typeOfPage
//        vc.value = value
//        navigationController?.pushViewController(vc, animated: true)
//    }

    func pushToCommunication() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "CommunicationsViewController") as! CommunicationsViewController
//        navigationController?.pushViewController(vc, animated: true)
    }

//    func pushToNewsletters() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "NewslettersViewController") as! NewslettersViewController
//        navigationController?.pushViewController(vc, animated: true)
//    }

    func pushToContactUs() {
        let storyboardMain = UIStoryboard(name: "ContactUsStoryboard", bundle: nil)
        let vc = storyboardMain.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        vc.isRevealedAdded = false
        navigationController?.pushViewController(vc, animated: true)
    }
    func pushToApps() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "AppsViewController") as! AppsViewController
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func pushtoPayementVC() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "PaymentsVC") as! PaymentsVC
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    

    func pushToTeacherContact() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "TeacherContactViewController") as! TeacherContactViewController
//        navigationController?.pushViewController(vc, animated: true)
    }

    func pushToAbsence() {
//        let storyboardMain = UIStoryboard(name: "AbsenceAndEarlyPickupStoryBoard", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "ReportAbsenceViewController") as! ReportAbsenceViewController
//        navigationController?.pushViewController(vc, animated: true)
    }

    
    func pushToPaymentFirstVC() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "PaymentFirstVc") as! PaymentFirstVc
//        vc.isRevealedAdded = false
//        navigationController?.pushViewController(vc, animated: true)
    }
    func pushToLunchVC() {
//        let storyboardLunchBox = UIStoryboard(name: "LunchBoxStoryBoard", bundle: nil)
//        let vc = storyboardLunchBox.instantiateViewController(withIdentifier: "LunchBoxVC") as! LunchBoxVC
//        vc.isRevealedAdded = false
//        navigationController?.pushViewController(vc, animated: true)
    }

    func pushToEarlyYearsVC() {
//        let vc = EarlyYearsViewController(nibName: "EarlyYearsViewController", bundle: nil)
//        vc.isRevealedAdded = false
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToPrimaryYearsVC() {
//        let vc = PrimaryYearsViewController(nibName: "PrimaryYearsViewController", bundle: nil)
//        vc.isRevealedAdded = false
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToSecondaryYearsVC() {
//        let vc = SecondaryYearsViewController(nibName: "SecondaryYearsViewController", bundle: nil)
//        vc.isRevealedAdded = false
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func pushToGalleryVC() {
//        let vc = GalleryViewController(nibName: "GalleryViewController", bundle: nil)
//        vc.isRevealedAdded = false
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
//    func pushToViewAbsence(absenceRequest: AbsenceRequest, studentList: StudentList ) {
//        let storyboardMain = UIStoryboard(name: "AbsenceAndEarlyPickupStoryBoard", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "ViewAbsenceViewController") as! ViewAbsenceViewController
//        vc.absenceRequest = absenceRequest
//        vc.studentList = studentList
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
//    func pushToViewEarlyPickUp(earlyPickupArray: EarlyPickupArray, studentList: StudentList ) {
//        let storyboardMain = UIStoryboard(name: "AbsenceAndEarlyPickupStoryBoard", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "EarlyPickUpDetailsViewController") as! EarlyPickUpDetailsViewController
//            vc.earlyPickArray = earlyPickupArray
//            vc.studentList = studentList
//        navigationController?.pushViewController(vc, animated: true)
//    }


    func pushToAddAbsence(stu_ID: String) {
//        let storyboardMain = UIStoryboard(name: "AbsenceAndEarlyPickupStoryBoard", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "AddAbsenceViewController") as! AddAbsenceViewController
//            vc.studentID = stu_ID
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToAddEarlyPickUp(stu_ID: String) {
//        let storyboardMain = UIStoryboard(name: "AbsenceAndEarlyPickupStoryBoard", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "EarlyPickUpSubmitViewController") as! EarlyPickUpSubmitViewController
//            vc.studentID = stu_ID
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func pushToSocialMedia() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "SocialMediaViewController") as! SocialMediaViewController
//        navigationController?.pushViewController(vc, animated: true)
    }

    func pushToCommonWeb(url: String = "", fromSocialMedia: Bool = false, titleStr: String = "", isTermsService: Bool = false) {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "CommonWebViewController") as! CommonWebViewController
//        vc.url = url
//        vc.fromSocialMedia = fromSocialMedia
//        vc.titleStr = titleStr
//        vc.isTermsService = isTermsService
//        navigationController?.pushViewController(vc, animated: true)
    }

    func pushToTimeTable() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "TimeTableViewController") as! TimeTableViewController
//        navigationController?.pushViewController(vc, animated: true)
    }

    
    func pushToWeblinkPdf(isPdf: Bool, pdfName: String = "", url: String = "", titlename: String = "") {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "ParentEssentialsInnerViewController") as! ParentEssentialsInnerViewController
//        vc.isPdf = isPdf
//        vc.pdfName = pdfName
//        vc.url = url
//        vc.titleName = titlename
//        navigationController?.pushViewController(vc, animated: true)
    }

    func pushToForms() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "FormsViewController") as! FormsViewController
//        navigationController?.pushViewController(vc, animated: true)
    }

    func pushToTermDates() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "TermDatesViewController") as! TermDatesViewController
//        navigationController?.pushViewController(vc, animated: true)
    }
    func pushToCurriculum() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "CurriculumViewController") as! CurriculumViewController
//        navigationController?.pushViewController(vc, animated: true)
    }
    func pushToCommonTableVC(titleStr: String) {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "CommonTableViewController") as! CommonTableViewController
//        vc.titleStr = titleStr
//        navigationController?.pushViewController(vc, animated: true)
    }

    func pushToSettings() {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
//        vc.isRevealedAdded = false
//        navigationController?.pushViewController(vc, animated: true)
    }

}
extension UIViewController {
    @objc func addRevealToSelfForGalleryVC() {
        let mainStoryBoard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let controller:RevealViewCV = mainStoryBoard.instantiateViewController(withIdentifier: "RevealViewCV") as! RevealViewCV
        controller.delegate = parent as? RevealDelegate
        let width = UIScreen.main.bounds.width
        print("widthValue: \(width)")
        controller.view.frame = CGRect(x: -(width), y: 0, width: width, height: view.frame.height)
        self.view.addSubview(controller.view)
        self.addChild(controller)
        controller.didMove(toParent: self)

//        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(showReveal))
//        gesture.direction = .right
//        self.view.addGestureRecognizer(gesture)

        // Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(panGestureRecognizer)

        hideRevealBool.bind { (completed) in
            if completed {
                self.hideReveal()
                hideRevealBool.value = false
            }
        }
    }
}
extension UIViewController {

    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {

        let positionX = sender.translation(in: self.view).x
        let velocityX = sender.velocity(in: self.view).x

        let y = sender.translation(in: self.view).y

        let isXZero: Bool = getXPosition() == 0.0 ? true : false

        switch sender.state {

        case .possible:
            break

        case .began:
            if y <= 0 && y >= 0 {
                print(y)
                if velocityX < 0 {
                } else {
                    if getXPosition() != 0 {
                        addRevealToView()
                    }
                }
            }

        case .changed:
            if velocityX <= 0 { //Close
                //                print(positionX)
                if isXZero {
                    changeRevealX(x: -200)
                } else {
                    changeRevealX(x: -self.view.frame.width + positionX)    //Half Drag
                }
            }
            else {    //open

                if getXPosition() <= 0 {   // For Drag
                    let x = -self.view.frame.width + (positionX)
                    changeRevealX(x: x)
                } else {
                    visibleReveal(x: 0)
                }
            }

        case .ended:
            print("Dragging End")
            if velocityX <= 0 { //close
                visibleReveal(x: -SCREEN_WIDTH)
            } else {    //open
                visibleReveal(x: 0)
            }
        case .cancelled:
            break
        case .failed:
            break
        @unknown default:
            break
        }
    }

    func addRevealToView() {

        if children.count > 0 {
            if children[0] is RevealViewCV {
                let width = self.view.frame.width
                children[0].view.frame = CGRect(x: -width, y: 0, width: width, height: view.frame.height)
            }
        }
    }

    func changeRevealX(x: CGFloat) {

        if children.count > 0 {
            if children[0] is RevealViewCV {
                children[0].view.frame.origin.x = x
                view.layoutIfNeeded()
            }
        }

        //        if children.count > 0 {
        //            if children[0] is RevealViewController {
        //                let width = self.view.frame.width
        //                children[0].view.frame = CGRect(x: x, y: 0, width: width, height: view.frame.height)
        //            }
        //        }

    }

    func getXPosition() -> CGFloat {

        if children.count > 0 {
            if children[0] is RevealViewCV {
                let x = children[0].view.frame.origin.x
                return x
            }
        }
        return -52
    }

    func visibleReveal(x: CGFloat) {

        if children.count > 0 {
            if children[0] is RevealViewCV {
                UIView.animate(withDuration: 0.3) { [self] in
                    children[0].view.frame.origin.x = x
                }
            }
        }
    }
    //End Swipe Gesture
    
    var topbarHeight: CGFloat {
        
        if #available(iOS 13.0, *) {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        } else {
            return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        }
    }
}
extension UIViewController {
    @objc func getStringFileContentFromBundle(fileName:String) ->String {
        let fileNameWithoutExtension = fileName.components(separatedBy: ".").first ?? fileName
        let extensionString = fileName.components(separatedBy: ".").last ?? "txt"
        if let path = Bundle.main.path(forResource: fileNameWithoutExtension, ofType: extensionString) {
            do {
                let dataString = try String(contentsOfFile: path)
                return dataString
              } catch {
                   return ""
              }
        }
        return ""
    }
}

extension UIView {
    
   @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius}
        set { self.layer.cornerRadius = newValue}
    }
    
    
    
    
}
