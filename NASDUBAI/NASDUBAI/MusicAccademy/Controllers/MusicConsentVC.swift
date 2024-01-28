//
//  MusicConsentVC.swift
//  NAS
//
//  Created by Mobatia Mac on 14/08/23.
//  Copyright © 2023 AJITH. All rights reserved.
//

import UIKit

class MusicConsentVC: UIViewController {
    
    @IBOutlet weak var constentBgView: UIView!
    @IBOutlet weak var constentButton1View: UIView!
    @IBOutlet weak var constentButton2View: UIView!
    
    var onSubmit:(Int) -> Void = { _ in }
    //    0- instrument owned
    //    1- instrument purchase
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUi()
    }
    
    func setupUi() {
        constentBgView.layer.cornerRadius = 10
        constentBgView.layer.masksToBounds = true
        self.constentButton1View.layer.cornerRadius = 5
        self.constentButton2View.layer.cornerRadius = 5
    }
    
    @IBAction func alreadyHaveInstrumentButtonTapped() {
        dismiss(animated: true) { [weak self] in
            self?.onSubmit(0)
        }
    }
    @IBAction func purchaseInstrumentButtonTapped() {
        dismiss(animated: true) { [weak self] in
            self?.onSubmit(1)
        }
    }
    @IBAction func closeButtonTapped() {
        dismiss(animated: true)
    }
}
