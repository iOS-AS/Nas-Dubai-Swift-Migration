//
//  StudentSelectionView.swift
//  MobiQuiz
//
//  Created by User1 on 11/04/20.
//  Copyright © 2020 Stebin. All rights reserved.
//

import UIKit

//Use this code for calling this Viewcontroller
//NSString * storyboardName = @"Storyboard";
//UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//StudentSelectionView * vc = [storyboard instantiateViewControllerWithIdentifier:@"StudentSelectionView"];
//vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//[self presentViewController:vc animated:YES completion:nil];

@objc protocol selectionDelegate  {
    @objc func selectedStudentData(index:Int)
}

@objc class StudentSelectionView: UIViewController {
    
    @IBOutlet weak var corneredBgImageViewForPopUpStudentList: UIImageView!
    @IBOutlet weak var innerPopUpViewForStudentList: UIView!
    @IBOutlet weak var studentIconImageView: UIImageView!
    
    @IBOutlet weak var baseOuterView: UIView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var studentList: [StudentList] = []
    var typeOfPage: TypeOfPage?
    @objc var selectedStudent: String?
    
    @objc var selectionDelegate: selectionDelegate?
    //    @objc var typeOfPage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if studentList.count == 0 {
        //            loadLocalData()
        //        }
        loadLocalData()
        callStudentListAPI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        baseOuterView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        outerView.layer.cornerRadius = SCREEN_HEIGHT * 0.01
        outerView.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.updateView(.zoomIn)
        }
    }
    
    func setPopUpViewUI(){
        
        self.studentIconImageView.layer.cornerRadius = self.studentIconImageView.frame.size.width/2
        self.studentIconImageView.clipsToBounds = true
        self.studentIconImageView.backgroundColor = UIColor.clear
        
        self.innerPopUpViewForStudentList.layer.masksToBounds = false
        self.innerPopUpViewForStudentList.layer.shadowOffset = CGSize(width: 0, height: -10)
        self.innerPopUpViewForStudentList.layer.shadowRadius = 5
        self.innerPopUpViewForStudentList.layer.shadowOpacity = 0.5
        self.innerPopUpViewForStudentList.backgroundColor = UIColor.clear
        
        self.corneredBgImageViewForPopUpStudentList.layer.cornerRadius = 5
        self.corneredBgImageViewForPopUpStudentList.clipsToBounds = true
        self.corneredBgImageViewForPopUpStudentList.backgroundColor = UIColor.clear
    }
    
    @IBAction func dismissButtonAction(_ sender: UIButton) {
        
        if let _ = studentList.firstIndex(where: { obj in
            obj.name == (selectedStudent ?? "")
        }) {
            print("Student Availble")
        }
        else {
            print("The selected student is not available in studentlist. So we are setting the first student as a selected student")
            if let del = selectionDelegate {
                del.selectedStudentData(index: (studentList.count > 0 ? 0 : -1) )
            }
        }
        updateView(.zoomOut)
    }
}

//MARK:- TableView Methods
extension StudentSelectionView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_HEIGHT * 0.08 //40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "StudentListCell") as? StudentListCell {
//            cell.configure(studentList[indexPath.row], typeOfPage)
//            return cell
//        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let del = selectionDelegate {
            print(del)
            del.selectedStudentData(index: indexPath.row)
            updateView(.zoomOut)
        }
//        self.selectionDelegate?.selectedStudentData(index: indexPath.row)
//        updateView(.zoomOut)
    }
}

//MARK:- Functions
extension StudentSelectionView {
    
    private func loadLocalData() {
        
//        let data = AppDelegate.getStudentList()
//        guard let arrayOfStudents = data as? [[String: Any]] else {
//            return
//        }
        //["section": 14ism, "id": 4711, "class": 14, "house": , "photo": , "wallet": 341, "name": tala alawieh]
//        studentList.removeAll()
//        let _ = arrayOfStudents.map( { studentList.append(StudentList($0)) })
//        tableView.reloadData()
    }
    
    private func updateView(_ typeOfAction: TypeOfAction?) {
        
        let scale: CGFloat = typeOfAction == .zoomIn ? 1.0 : 0.01
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseInOut]) {
            self.baseOuterView.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.view.layoutIfNeeded()
        } completion: { done in
            if typeOfAction == .zoomOut {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func callStudentListAPI() {
        //        self.activityIndicatior.startAnimating()
       
    }
    
    /*
     private func callStudentListAPI() {
     
     //        self.activityIndicatior.startAnimating()
     APIManager.getStudentList { (responseDict, responseString, Error) in
     
     if Error == nil {
     
     guard error == nil else {
     AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
     return
     }
     
     guard let dict = responseDict as? [String : Any] else { return }
     print(dict)
     
     let studentListResponse = StudentListApiresp(dict)
     
     if studentListResponse.responsecode == RESPONSE_SUCCESS {
     
     guard studentListResponse.response.statuscode ==  STATUSCODE_SUCCESS else {
     AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
     return
     }
     
     self.studentList = studentListResponse.response.data
     if studentListResponse.response.data.count == 0 {
     //  AppDelegate.showSingleButtonAlert("Alert", "No Student Data Available", 0)
     } else {
     DispatchQueue.main.async {
     self.tableView.reloadData()
     }
     //---- saving api response to documents directory ----//
     guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
     let filePath = path.appendingPathComponent("StudentListFull.dat")
     
     //Load the array
     do {
     let data = try NSKeyedArchiver.archivedData(withRootObject: studentListResponse.response.data, requiringSecureCoding: false)
     try data.write(to: filePath)
     } catch (let error) {
     print(error.localizedDescription)
     print("Couldn't write file")
     }
     }
     
     }
     else if (studentListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || studentListResponse.responsecode == RESPONSE_TOKEN_INVALID || studentListResponse.responsecode == RESPONSE_TOKENMISSING){
     
     APIManager.getAccessToken { (responseObject, error) in
     
     guard error == nil else {
     AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
     return
     }
     let accessToken = responseObject!["access_token"] as! String
     if accessToken.count != 0{
     self.callStudentListAPI()
     }
     }
     }
     else {
     //                    AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
     }
     
     
     //                self.activityIndicatior.stopAnimating()
     let studentListResponse = StudentListApiresp(responseDict as! [String : Any] )
     
     print(responseDict)
     
     if studentListResponse.responsecode == RESPONSE_SUCCESS {
     
     if studentListResponse.response.statuscode ==  STATUSCODE_SUCCESS {
     
     self.studentList = studentListResponse.response.data
     
     if studentListResponse.response.data.count == 0 {
     //  AppDelegate.showSingleButtonAlert("Alert", "No Student Data Available", 0)
     }
     else {
     DispatchQueue.main.async {
     self.tableView.reloadData()
     }
     
     //---- saving api response to documents directory ----//
     guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
     let filePath = path.appendingPathComponent("StudentListFull.dat")
     
     //Load the array
     do {
     let data = try NSKeyedArchiver.archivedData(withRootObject: studentListResponse.response.data, requiringSecureCoding: false)
     try data.write(to: filePath)
     } catch (let error) {
     print(error.localizedDescription)
     print("Couldn't write file")
     }
     }
     }
     else {
     //  AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
     }
     }
     
     else if (studentListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || studentListResponse.responsecode == RESPONSE_TOKEN_INVALID || studentListResponse.responsecode == RESPONSE_TOKENMISSING){
     
     APIManager.getAccessToken { (responseObject, error) in
     
     if error == nil{
     let accessToken = responseObject!["access_token"] as! String
     if accessToken.count != 0{
     self.callStudentListAPI()
     }
     else {
     // AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
     }
     }
     }
     }
     }
     else {
     //                self.activityIndicatior.stopAnimating()
     //AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
     }
     }
     }
     */
}


/*
protocol selectionDelegate: NSObjectProtocol  {
    func selectedStudentData(index:Int)
}

class StudentSelectionView: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
        
    @IBOutlet weak var corneredBgImageViewForPopUpStudentList: UIImageView!
    
    @IBOutlet weak var innerPopUpViewForStudentList: UIView!
    
    
    @IBOutlet weak var studentIconImageView: UIImageView!
    
    @IBOutlet weak var baseOuterView: UIView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var studentList: [StudentList] = []
    weak var selectionDelegate: selectionDelegate?
    
    @objc var typeOfPage: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setPopUpViewUI()
        loadLocalData()
        callStudentListAPI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        baseOuterView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        
        outerView.layer.cornerRadius = SCREEN_HEIGHT * 0.015
        outerView.clipsToBounds = true
    }
    
    func setPopUpViewUI(){
        
        self.studentIconImageView.layer.cornerRadius = self.studentIconImageView.frame.size.width/2
        self.studentIconImageView.clipsToBounds = true
        self.studentIconImageView.backgroundColor = UIColor.clear
        
        self.innerPopUpViewForStudentList.layer.masksToBounds = false
        self.innerPopUpViewForStudentList.layer.shadowOffset = CGSize(width: 0, height: -10)
        self.innerPopUpViewForStudentList.layer.shadowRadius = 5
        self.innerPopUpViewForStudentList.layer.shadowOpacity = 0.5
        self.innerPopUpViewForStudentList.backgroundColor = UIColor.clear
        
        self.corneredBgImageViewForPopUpStudentList.layer.cornerRadius = 5
        self.corneredBgImageViewForPopUpStudentList.clipsToBounds = true
        self.corneredBgImageViewForPopUpStudentList.backgroundColor = UIColor.clear
    }
    
    @IBAction func dismissButtonAction(_ sender: UIButton) {
        
//        self.dismiss(animated: true, completion: nil)
        self.updateView(.zoomOut)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_HEIGHT * 0.09 //40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StudentListCell") as? StudentListCell {
            cell.configure(studentList[indexPath.row])
            return cell
        }
        return UITableViewCell()
        
        /*
         let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
         let imageInCell = UIImageView.init(frame: CGRect.init(x: 5, y: 5, width: 30, height: 30))
         imageInCell.layer.cornerRadius = imageInCell.frame.width / 2
         imageInCell.clipsToBounds = true
         imageInCell.layer.borderWidth = 1
         imageInCell.layer.borderColor = UIColor (named: "NAS_Color_1")?.cgColor
         imageInCell.image = UIImage.init(named: "studentIcon.png")
         
         let nameLabelInCell = UILabel.init(frame: CGRect.init(x: 40, y: 0, width: tableView.frame.width - 50, height: 25))
         nameLabelInCell.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
         nameLabelInCell.font = UIFont(name:"SourceSansPro-Regular", size: 14)
         
         let stdLabelInCell = UILabel.init(frame: CGRect.init(x: 40, y: 25, width: tableView.frame.width - 50, height: 15))
         nameLabelInCell.text = studentList[indexPath.row].name
         stdLabelInCell.text = studentList[indexPath.row].section
         stdLabelInCell.textColor = UIColor.lightGray
         stdLabelInCell.font = nameLabelInCell.font.withSize(11)
         cell.addSubview(imageInCell)
         cell.addSubview(stdLabelInCell)
         cell.backgroundColor = .clear
         
         if (studentList[indexPath.row].photo.count > 0) {
         
         let imageUrlString = studentList[indexPath.row].photo.replacingOccurrences(of: " ", with: "%20")
         JMImageCache.shared()?.image(for: URL(string: imageUrlString), completionBlock: { (image) in
         imageInCell.image = image
         }, failureBlock: { (request, response, error) in
         imageInCell.image = UIImage.init(named: "studentIcon.png")
         })
         }
         
         let disclosureArrow = UIImageView.init(frame: CGRect.init(x: tableView.frame.width - 20 , y: 10, width: 20, height: 20))
         disclosureArrow.image = UIImage.init(named: "rightarrow")
         cell.addSubview(disclosureArrow)
         
         let separatorVIew = UILabel.init(frame: CGRect.init(x: 10, y: 39, width: tableView.frame.width - 20, height: 0.75))
         separatorVIew.backgroundColor = UIColor(red: 74.0/255.0, green: 180.0/255.0, blue: 197.0/255.0, alpha: 1.0)
         cell.addSubview(separatorVIew)
         cell.addSubview(nameLabelInCell)
         cell.selectionStyle = .none
         
         return cell
         */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectionDelegate?.selectedStudentData(index: indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
}

extension StudentSelectionView {
    
    private func loadLocalData() {
        
        let studentListArray = AppDelegate.getStudentList()
        print(studentListArray)
        
        /*
        _studentListArray = [[NSMutableArray alloc]initWithArray: [AppDelegate getStudentList]];
        [_tableViewStudent reloadData];
        if(_studentListArray.count==0){
            [AppDelegate showSingleButtonAlert:@"Alert" :@"No Student Data Available" :0];
        }
        NSString *passedStudentId = [DefaultWrapper getLoggedInStudentId];
       
        if (!isDefaultStudentSelected) {
            
            isDefaultStudentSelected = YES;
            if (_studentListArray.count>0) {
                
                // If alredy selected a child, reload his/her details
                
                if (passedStudentId.length > 0) {
                    for (int i=0; i<_studentListArray.count; i++) {
                        if ([[_studentListArray objectAtIndex:i] isKindOfClass:[NSDictionary class]]) {
                            if ([[[_studentListArray objectAtIndex:i] objectForKey:@"id"] isKindOfClass:[NSString class]]) {
                                if ([[[_studentListArray objectAtIndex:i] objectForKey:@"id"] isEqualToString:passedStudentId]) {
                                    
                                    if ([[[_studentListArray objectAtIndex:i] objectForKey:@"name"] isKindOfClass:[NSString class]]) {
                                        _childNameField.text = [[_studentListArray objectAtIndex:i] objectForKey:@"name"];
                                         if ([[[_studentListArray objectAtIndex:i] objectForKey:@"class"] isKindOfClass:[NSString class]]) {
                                             classStr = [[_studentListArray objectAtIndex:i] objectForKey:@"class"];
                                         }
                                        
                                        if ([[[_studentListArray objectAtIndex:i] objectForKey:@"photo"] isKindOfClass:[NSString class]]) {
                                            NSString *photoUrl = [[_studentListArray objectAtIndex:i] objectForKey:@"photo"];
                                            [[JMImageCache sharedCache] imageForURL:[NSURL URLWithString:photoUrl] completionBlock:^(UIImage *image) {
                                                _studentPhotoImageView.image = image;
                                            } failureBlock:^(NSURLRequest *request, NSURLResponse *response, NSError *error) {
                                                
                                            }];
                                        }
                                        
                                        selectedStudentId = [[_studentListArray objectAtIndex:i] objectForKey:@"id"];
                                        [self getLeaveListForStudentFromApi];
                                    }
                                    break;
                                    return;
                                }
                            }
                        }
                    }
                }else {
                    // If not selected a child, load first child details
                    if ([[_studentListArray objectAtIndex:0] isKindOfClass:[NSDictionary class]]) {
                        
                        if ([[[_studentListArray objectAtIndex:0] objectForKey:@"name"] isKindOfClass:[NSString class]]) {
                            _childNameField.text = [[_studentListArray objectAtIndex:0] objectForKey:@"name"];
                        }
                        if ([[[_studentListArray objectAtIndex:0] objectForKey:@"class"] isKindOfClass:[NSString class]]) {
                            classStr = [[_studentListArray objectAtIndex:0] objectForKey:@"class"];
                        }
                        
                        if ([[[_studentListArray objectAtIndex:0] objectForKey:@"id"] isKindOfClass:[NSString class]]) {
                            selectedStudentId = [[_studentListArray objectAtIndex:0] objectForKey:@"id"];
                            firstId = selectedStudentId;
                            if (_studentListArray.count>0) {
                                
                                //---- saving api response to documents directory ----//
                                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                NSString *documentsDirectory = [paths objectAtIndex:0];
                                NSString *strPath = [NSString stringWithFormat:@"leavelist-%d.dat",0];
                               
                                // NSString *FileName = [documentsDirectory stringByAppendingPathComponent:@"permissionslipstudent.dat"];
                                NSString *FileName = [documentsDirectory stringByAppendingPathComponent:strPath];
                                
                                //Load the array
                                NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile: FileName];
                                array = [[NSMutableArray alloc] initWithArray: _studentListArray];
                                //[yourArray writeToFile:yourArrayFileName atomically:YES];
                                BOOL result = [NSKeyedArchiver archiveRootObject:array toFile:FileName];
                                NSLog(@"-----result-----%hhd",result);
                                [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"selectleaveInd"];
                                [[NSUserDefaults standardUserDefaults]synchronize];
                                
                            }
                            [self getLeaveListForStudentFromApi];
                        }
                        
                        if ([[[_studentListArray objectAtIndex:0] objectForKey:@"photo"] isKindOfClass:[NSString class]]) {
                            NSString *photoUrl = [[_studentListArray objectAtIndex:0] objectForKey:@"photo"];
                            [[JMImageCache sharedCache] imageForURL:[NSURL URLWithString:photoUrl] completionBlock:^(UIImage *image) {
                                _studentPhotoImageView.image = image;
                            } failureBlock:^(NSURLRequest *request, NSURLResponse *response, NSError *error) {
                                
                            }];
                        }
                    }
                }
            }
        }
        */
    }
    
    private func updateView(_ typeOfAction: TypeOfAction?) {
        
        let scale: CGFloat = typeOfAction == .zoomIn ? 1.0 : 0.01

        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseInOut]) {
            
            self.baseOuterView.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.view.layoutIfNeeded()
        } completion: { done in
            if typeOfAction == .zoomOut {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    private func callStudentListAPI() {
        
        //        self.activityIndicatior.startAnimating()
        APIManager.getStudentList { (responseDict, responseString, Error) in
            
            if Error == nil{
                //                self.activityIndicatior.stopAnimating()
                let studentListResponse = StudentListApiresp(responseDict as! [String : Any] )
                
                if studentListResponse.responsecode == RESPONSE_SUCCESS{
                    if studentListResponse.response.statuscode ==  STATUSCODE_SUCCESS {
                        if studentListResponse.response.data.count == 0 {
                            AppDelegate.showSingleButtonAlert("Alert", "No Student Data Available", 0)
                            self.updateView(.zoomOut)
                        }
                        else {
                            self.studentList = studentListResponse.response.data
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.updateView(.zoomIn)
                            }
                            //                            self.setStudentData(index: 0)
                        }
                    }
                    else {
                        AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
                        self.updateView(.zoomOut)
                    }
                }
                
                else if (studentListResponse.responsecode == RESPONSE_TOKEN_EXPIRED || studentListResponse.responsecode == RESPONSE_TOKEN_INVALID || studentListResponse.responsecode == RESPONSE_TOKENMISSING){
                    
                    APIManager.getAccessToken { (responseObject, error) in
                        
                        if error == nil{
                            let accessToken = responseObject!["access_token"] as! String
                            if accessToken.count != 0{
                                self.callStudentListAPI()
                            }
                            else {
                                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
                                self.updateView(.zoomOut)
                            }
                        }
                    }
                }
            }
            else {
                //                self.activityIndicatior.stopAnimating()
                AppDelegate.showSingleButtonAlert("Alert", "Cannot continue. Please try again later", 0)
                self.updateView(.zoomOut)
            }
        }
    }
}
*/
