//
//  ContactUsFstCell.swift
//  BISAD
//
//  Created by Mobatia Cathu 2 on 28/12/20.
//

import UIKit

class ContactUsFstCell: UITableViewCell {


    var contactUsModel = ContactUsModel()

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBAction func mapButtonTap(_ sender: UIButton) {
        contactUsModel.viewLocation()
    }

    var element:String! {
        didSet {
            descriptionLabel.text = element
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated) 
    }

}
