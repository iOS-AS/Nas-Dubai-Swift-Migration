//
//  RevealVC.swift
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

class RevealVC: UIViewController {

    var inDrag = false
    var delegate: RevealDelegate?

    var revealArray = ["Home",
                       "Notifications",
                       "Calendar",
                       "Payments", "Lunch Box", "Parent Essentials" ,
                       "Absence & Early Pickup", "Early Years",
                       "Primary", "Secondary",
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
 

}


