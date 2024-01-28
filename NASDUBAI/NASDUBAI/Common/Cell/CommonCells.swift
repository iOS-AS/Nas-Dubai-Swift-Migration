//
//  CommonCells.swift
//  BISAD
//
//  Created by Mobatia Cathu 2 on 16/12/20.
//

import UIKit

class CommonCells: UITableViewCell {

    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var itemLbl: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var themeColor = UIColor(named: "Brand Color") {
        didSet {
            lineView.backgroundColor = themeColor
            arrowImageView.image = UIImage(named: "rightarrow")?.withRenderingMode(.alwaysTemplate)
            arrowImageView.tintColor = themeColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        lineView.backgroundColor = themeColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
