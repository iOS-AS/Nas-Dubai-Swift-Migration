//
//  SingleButtonAlertVC.swift
//  BSKL_SWIFT_2023
//
//  Created by MOB-IOS-05 on 15/09/23.
//

import UIKit
@objc protocol SingleBtnAlertDelegate {
    func dismissPressed()
}
class SingleButtonAlertVC: UIViewController {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var alertMessageLbl: UILabel!
    @IBOutlet weak var alertTitleLbl: UILabel!
    @IBOutlet weak var bgBtn: UIButton!
    @objc var message = ""
    @objc var titleString = ""
    @objc var delegate: SingleBtnAlertDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        iconImageView.setWhiteBorder()
        alertMessageLbl.text = message
        if titleString != "" {
            alertTitleLbl.text = titleString
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        view.zoomIn(bgBtn) {}
    }

    @IBAction func buttonPressed(_ sender: Any) {
        view.zoomOut(bgBtn) {
            self.dismiss(animated: false) {
                self.delegate?.dismissPressed()
            }
        }
    }
    
}
