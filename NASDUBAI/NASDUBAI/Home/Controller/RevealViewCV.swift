//
//  RevealViewCV.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 17/01/24.
//

import UIKit

protocol RevealDelegate {
    func createDragableCell(frame: CGRect, title: String)
    func moveDragableCell(point: CGPoint)
    func dropDragableCell(sender: UIGestureRecognizer)
}

var hideRevealBool: Observable<Bool> = Observable(false)

class RevealViewCV: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgBtn: UIButton!
    var inDrag = false
    var delegate: RevealDelegate?

    var revealArray = ["Home",
                       "Notifications",
                       "Calendar",
                       "Payments", "Lunch Box", "Parent Essentials" ,
                       "Absence & Early Pickup", "Early Years",
                       "Primary", "Secondary",
                       "Reports",
                       "Permission Forms", "Enrichment",
                       "Parents Meeting", "Gallery",
//                       "Term Dates",
//                       "Curriculum",
                       //"Staff Directory",
                       "Contact Us", "About Us" ]


    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressAction(_:)))
        tableView.addGestureRecognizer(gesture)
    }
    @IBAction func bgBtnPressed(_ sender: UIButton) {
        hideRevealBool.value = true
    }

    @objc func longPressAction(_ sender: UIGestureRecognizer) { 

        if sender.state == .began {
            let touchPoint = sender.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                if indexPath.row == 0 {
                    return
                }
                inDrag = true
                let splitView = splitViewController?.view
                let point = sender.location(in: splitView)
                let size = CGSize(width: 150, height: 45)
                let frame = CGRect(x: point.x - (size.width / 2.0), y: point.y - (size.height / 2.0), width: size.width, height: size.height)
                delegate?.createDragableCell(frame: frame, title: revealArray[indexPath.row])

            }
        } else if sender.state == .changed && inDrag {
            let splitView = splitViewController?.view
            let point = sender.location(in: splitView)
            delegate?.moveDragableCell(point: point)
        } else if sender.state == .ended && inDrag {
            delegate?.dropDragableCell(sender: sender)
        }
    }

}


