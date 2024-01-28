//
//  RevealCell.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 23/01/24.
//

import UIKit

class RevealCell: UITableViewCell {
    
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    var element: String! {
        didSet {
            itemLbl.text = element
            itemImageView.image = UIImage(named: "sideBar_\(element.capitalized).png")
        }
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
