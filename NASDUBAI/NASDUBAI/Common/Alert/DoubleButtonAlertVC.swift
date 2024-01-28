//
//  DoubleButtonAlertVC.swift
//  NAISAK
//
//  Created by Mobatia Mac on 23/08/23.
//

import UIKit

protocol DoubleBtnAlertDelegate {
    func okPressed(tag: Int)
}

class DoubleButtonAlertVC: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var alertMessageLbl: UILabel!
    @IBOutlet weak var alertTitleLbl: UILabel!
    @IBOutlet weak var bgBtn: UIButton!
    var tag = 0
    var message = ""
    var titleStr = ""
    var delegate: DoubleBtnAlertDelegate?
    var index:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        alertMessageLbl.text = message
        alertTitleLbl.text = titleStr
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
    }

    @IBAction func dismissPressed(_ sender: UIButton) {
            self.dismiss(animated: false, completion: nil)
    }

    @IBAction func okPressed(_ sender: UIButton) {
            self.dismiss(animated: false) { [self] in
                delegate?.okPressed(tag: tag)
        }
    }
}
