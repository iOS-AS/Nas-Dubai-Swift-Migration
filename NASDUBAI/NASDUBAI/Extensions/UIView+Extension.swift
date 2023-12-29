//
//  UIView+Extension.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 29/12/23.
//

import UIKit

extension UIView {

    func setWhiteBorder() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }

    func setBlueBorder() {
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.3519416153, green: 0.7905560732, blue: 0.8365017176, alpha: 1).cgColor
    }
    
    func setGrayBorder() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.gray.cgColor
    }

    func startActivityIndicator() {
        let activityView = UIActivityIndicatorView(style: .white)
        activityView.color = #colorLiteral(red: 0.3519416153, green: 0.7905560732, blue: 0.8365017176, alpha: 1)
        activityView.center = self.center
        activityView.tag = 475647
        self.addSubview(activityView)
        activityView.startAnimating()
    }

    func stopActivityIndicator() {
        isUserInteractionEnabled = true
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
    }
    func shadow() {
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
    }
}
