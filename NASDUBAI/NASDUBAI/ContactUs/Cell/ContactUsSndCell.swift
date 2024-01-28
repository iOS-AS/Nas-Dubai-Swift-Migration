//
//  ContactUsSndCell.swift
//  BISAD
//
//  Created by Mobatia Cathu 2 on 28/12/20.
//

import UIKit

class ContactUsSndCell: UITableViewCell {


    @IBOutlet weak var headerTitleText: UILabel!
    @IBOutlet weak var mobLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailBtn: UIButton!
    
    var element: Contact! {
        didSet {
            headerTitleText.text = element.name
            mobLabel.text = element.phone
            emailLabel.text = element.email
        }
    }

    @IBAction func makePhoneCall(_ sender: UIButton) {
        var phone = element.phone!
        phone = phone.replacingOccurrences(of: "-", with: "")
        phone = phone.replacingOccurrences(of: " ", with: "")

        if let url = URL(string: "tel://\(phone)"),
           UIApplication.shared.canOpenURL(url) {
            print(url)
              if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
               } else {
                   UIApplication.shared.openURL(url)
               }
           } else {
                    // add error message here
           }
    }
    @IBAction func makeEmail(_ sender: UIButton) {
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
