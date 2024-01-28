//
//  PTAMeetingVC.swift
//  BISAD
//
//  Created by Amritha on 24/11/22.
//
import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON

class PTAMeetingVC: UIViewController {
    
    
    @IBOutlet weak var staffTitleLbl: UILabel!
    @IBOutlet weak var staffNameLbl: UILabel!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var sendOuterView: UIView!
    @IBOutlet weak var staffOuterView: UIView!
    @IBOutlet weak var studentOuterView: UIView!

    @IBOutlet weak var studentImgView: UIImageView!
    @IBOutlet weak var staffImgView: UIImageView!
    
    
    @IBOutlet weak var nextCalendar: UIImageView!
    
    
    
    @IBOutlet weak var reviewButton: UIButton!
    
    
    
    var studentID: String = ""
    var staffEmail: String?
    var staffId = ""
    var ptaCalendarModel = PtaCalendarModel()
    var dataArray: [String] = []
    var fetchedAllData = false
    var start = 0
    var limit = 100
    var stdClass = ""
    var stdName = ""
    var staffName = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addRevealToSelf()
        setupUI()
        staffOuterView.isHidden = true
        nextCalendar.isHidden = true
        
        // Do any additional setup after loading the view.
//        newsletterModel.getData(apiName: "letters", start: start, limit: limit) { data in
//            self.fetchedAllData = data?.count ?? 0 < self.limit
//            self.arrayOfItems = data ?? []
//        }
    }
    

    @IBAction func revealButtonPressed(_ sender: Any) {
        showReveal()
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        pushToHome()
    }
    
    
    
    @IBAction func nextPageButtonClicked(_ sender: Any) {
       
        getDataa()

    }
    
    
    
    @IBAction func reviewButtonClicked(_ sender: Any) {
        
        print("Hello")
        
        let stryBrd = UIStoryboard(name: "PTAMeetingReviewVC", bundle: nil)
        let vc = stryBrd.instantiateViewController(withIdentifier: "PTAMeetingReviewVC") as! PTAMeetingReviewVC
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
    @IBAction func infotutorialButton(_ sender: Any) {
//        pushToPTATutorial()
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "TutorialViewControllerPTA") as! TutorialViewControllerPTA
//        vc.modalPresentationStyle = .currentContext
//        vc.isFromInfoBtnA = true
//        self.present(vc, animated: true)
    }
    
    
    func getDataa(){
        
        dataArray.removeAll()
        
        if !ApiServices().checkReachability() {
            return
        }
        let url = ApiServices().BASE_URL + "pta-allotted-dates"
        let parameters: Parameters = ["student_id": studentID, "staff_id": Int(staffId)!]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            let (val, err) = ptaCalendarModel.processData(data: CF.processResponse(response, decodingType: PtaCalendar.self))
            if let e = err {
                if e == .tokenExpired {
                    ApiServices().getAccessToken {
                       getDataa()
                    }
                }
            } else if let v = val {
                
                UIApplication.topMostViewController?.view.stopActivityIndicator()
                //fetchedAllData = v.response.request?.count ?? 0 < limit
                fetchedAllData = v.data?.count ?? 0 < limit
                dataArray.append(contentsOf: v.data ?? [])
                
                let stryBrd = UIStoryboard(name: "PTAMeetingCalendarVC", bundle: nil)
                let vc = stryBrd.instantiateViewController(withIdentifier: "PTAMeetingCalendarVC") as! PTAMeetingCalendarVC
                    vc.presentdays = dataArray
                vc.studentId = studentID
                vc.staffId = staffId
                vc.stdClass = stdClass
                vc.stdName = stdName
                vc.staffName = staffName
                navigationController?.pushViewController(vc, animated: true)
                   
                view.stopActivityIndicator()
             
            }
        }
        
    }
    
    
    
    @IBAction func settingsButtonPressef(_ sender: Any) {
      //  pushToSettings()
    }
    
    
}
extension PTAMeetingVC {

    func setupUI() {
       

        staffImgView.image = UIImage(named: "addIconLarge")
        studentImgView.image = UIImage(named: "addIconLarge")
//        staffImgView.roundshape()
//        studentImgView.roundshape()

        //Creating tap gesture
        let staffTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.staffImagePressed(_ :)))
        staffTapGesture.numberOfTouchesRequired = 1
        staffImgView.addGestureRecognizer(staffTapGesture)

        let studentTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.studentImagePressed(_ :)))
        studentTapGesture.numberOfTouchesRequired = 1
        studentImgView.addGestureRecognizer(studentTapGesture)
    }

    @objc func staffImagePressed(_ sender: UITapGestureRecognizer) {
        print("staffImagePressed")
        //presentStaffSelection(self, studenID: studentID)
    }

    @objc func studentImagePressed(_ sender: UITapGestureRecognizer) {
        print("studentImagePressed")
       // presentStudentSelection(self)
      
    }
}

//MARK:- StudentDelegate
extension PTAMeetingVC: StudentDelegate {
    fileprivate func resetStaff() {

        // staffAddBtn.setBackgroundImage(UIImage(named: "addIconLarge"), for: .normal)
        staffImgView.image = UIImage(named: "addIconLarge")
        staffNameLbl.text = "Staff Name:-"
        //staffTitleLbl.text = "Staff Role:-"
        staffEmail = ""
        nextCalendar.isHidden = true
       // sendOuterView.isHidden = true
    }

    func selectedStudent(with data: StudentList) {
        staffOuterView.isHidden = false
        resetStaff()

        //        studentAddBtn.setBackgroundImage(#imageLiteral(resourceName: "studentIcon"), for: .normal)
        studentImgView.image = UIImage(named: "studentIcon")
        stdClass = data.sclass ?? ""
        stdName = data.name ?? ""
        if let photo = data.photo {
            if photo != "" {
                SDWebImageManager.shared().loadImage(
                    with: URL(string: photo),
                    options: .highPriority,
                    progress: nil) { [self] (image, data, error, cacheType, isFinished, imageUrl) in
                    //                    studentAddBtn.setBackgroundImage(image, for: .normal)
                        if image == nil {
                            studentImgView.image = UIImage(named: "studentIcon")
                        } else {
                            studentImgView.image = image
                        }
                }
            }
        }

        staffOuterView.zoomIn {}
        studentNameLbl.text = data.name
        studentID = data.id!
    }
}

//MARK:- StaffDelegate
extension PTAMeetingVC: StaffDelegate {

    func selectedStaff(with data: StaffList) {

        //        staffAddBtn.setBackgroundImage(#imageLiteral(resourceName: "teacherIcon"), for: .normal)
        staffImgView.image = UIImage(named: "teacherIcon")

        if let photo = data.imageURL {
            if photo != "" {
                SDWebImageManager.shared().loadImage(
                    with: URL(string: photo),
                    options: .highPriority,
                    progress: nil) { [self] (image, data, error, cacheType, isFinished, imageUrl) in
                    //                    staffAddBtn.setBackgroundImage(image, for: .normal)
                        if image == nil {
                            staffImgView.image = UIImage(named: "teacherIcon")
                        } else {
                            staffImgView.image = image
                        }
                }
            }
        }

        staffNameLbl.text = data.name
        //staffTitleLbl.text = data.role //data.title // use this label for setting staff role
//        staffEmail = data.email
        nextCalendar.isHidden = false
        staffId = "\(data.id ?? 0)"
        staffName = data.name ?? ""
        //sendOuterView.isHidden = false
        //sendOuterView.zoomIn {}
    }
}

