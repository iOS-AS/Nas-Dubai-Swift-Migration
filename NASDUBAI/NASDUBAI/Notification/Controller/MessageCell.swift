//
//  MessageCell.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 05/02/24.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    var element: NotificationModel! {
        didSet 
        {
            itemLbl.text = element.title
            itemImageView.image = UIImage(named: "alertIcon_" + element.alertType!.lowercased())
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

