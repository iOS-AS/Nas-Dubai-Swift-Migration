//
//  StudentSelectionVC.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 22/01/24.
//

import UIKit
import CoreData
protocol StudentDelegate {
    func selectedStudent(with data: StudentList)
}

class StudentSelectionVC: UIViewController {
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var bgBtn: UIButton!

    
    var delegate: StudentDelegate?
    var studentList: [StudentList] = []

    let studentSelectionModel = StudentSelectionModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        studentSelectionModel.getStudentFromCoreData { list in
            studentList = list
            tableView.reloadData()
        }

        iconImageView.setBlueBorder()
        view.zoomIn(bgBtn){}
    }

    @IBAction func dismissPressed(_ sender: UIButton) {
        view.zoomOut(bgBtn) {
            self.dismiss(animated: false, completion: nil)
        }
    }


    
}


extension StudentSelectionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentCell
        cell.element = studentList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        view.zoomOut(bgBtn) { [self] in
            dismiss(animated: false) {
                delegate?.selectedStudent(with: studentList[indexPath.row])
            }
        }

    }

}
