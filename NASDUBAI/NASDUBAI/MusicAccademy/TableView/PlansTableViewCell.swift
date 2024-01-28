//
//  PlansTableViewCell.swift
//  NAS
//
//  Created by Mobatia Mac on 14/08/23.
//  Copyright © 2023 AJITH. All rights reserved.
//

import UIKit

class PlansTableViewCell: UITableViewCell {
    
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var planLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
