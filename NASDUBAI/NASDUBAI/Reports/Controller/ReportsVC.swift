//
//  ReportsVC.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 18/01/24.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReportsVC: UIViewController {
    
    
    @IBOutlet weak var studentIconImageView: UIImageView!
    
    
    @IBOutlet weak var studentNameField: UITextField!
    
    @IBOutlet weak var studentNameOuterView: UIView!
    
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let studentSelectionModel = StudentSelectionModel()

    let reportsModel = ReportsModel()
    var dataArray: [ProgressReportArray] = [] {
        didSet {
            if dataArray.isEmpty {
                return alertMessage.value = K.noReports
            }
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRevealToSelf()
        studentNameOuterView.setBlueBorder()
        studentSelectionModel.getStudentFromCoreData { list in
            studentNameField.text = list.first?.name
            let url = list.first?.photo
            studentIconImageView.image = UIImage(named: "studentIcon.png")
            if url != "" {
                studentIconImageView.sd_setImage(with: URL(string: url!), placeholderImage: UIImage(named: "studentIcon.png"), completed: nil)
            }
            reportsModel.getData(studentID: list.first!.id!) { [self] (data) in
                dataArray = data ?? []
            }
        }

        showAlerts()
    }


    func getData(studentID: String) {
        if !ApiServices().checkReachability() {
            return
        }
        let url = BASE_URL + "progressreport"
        let parameters: Parameters = ["student_id": studentID]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        print("parameter\(parameters)")
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            let (val, err) = reportsModel.processData(data: CF.processResponse(response, decodingType: ProgressReport.self))
            if let e = err {
                if e == .tokenExpired {
                    ApiServices().getAccessToken {
                        getData(studentID: studentID)
                    }
                }
            } else if let v = val {
                UIApplication.topMostViewController?.view.stopActivityIndicator()
                dataArray = v.responseArray ?? []
                tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func studentDropDownPress(_ sender: UIButton) {
        presentStudentSelection(self)
    }
    @IBAction func logoPressed(_ sender: UIButton) {
        pushToHome()
    }
    
    @IBAction func settingsPressed(_ sender: UIButton) {
       // pushToSettings()
    }
    
    @IBAction func revealPressed(_ sender: UIButton) {
        showReveal()
    }
}
extension ReportsVC: StudentDelegate {
    func selectedStudent(with data: StudentList) {
        studentNameField.text = data.name
        let url = data.photo
        studentIconImageView.image = UIImage(named: "studentIcon.png")
        if url != "" {
            studentIconImageView.sd_setImage(with: URL(string: url!), placeholderImage: UIImage(named: "studentIcon.png"), completed: nil)
        }
        getData(studentID: data.id!)
    }
}


extension ReportsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        vw.backgroundColor = .white
        let lbl = UILabel(frame: CGRect(x: 10, y: 0, width: vw.frame.width - 10, height: vw.frame.height))
        lbl.backgroundColor = .white
        lbl.font = UIFont(name: "SourceSansPro-Semibold", size: 15)
        vw.addSubview(lbl)
        lbl.text = "Academic Year : \(dataArray[section].acyear ?? "")"

        return vw
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].data?.count ?? 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCells", for: indexPath) as! CommonCells
        cell.selectionStyle = .none
        cell.itemLbl.text = "   \(dataArray[indexPath.section].data?[indexPath.row].reportCycle ?? "")"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = dataArray[indexPath.section].data?[indexPath.row] {
            pushToWebPdf(isPdf: true, pdfName: data.reportCycle ?? "", url: data.viewreport ?? "", studentName: studentNameField.text)
        }
    }

}

