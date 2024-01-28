//
//  InstrumentOrdereSummaryTableViewCell.swift
//  NAS
//
//  Created by Joel Leo on 18/08/23.
//  Copyright © 2023 AJITH. All rights reserved.
//

import UIKit

class InstrumentOrdereSummaryTableViewCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subValue1Label: UILabel!
    @IBOutlet weak var subValue2Label: UILabel!
    @IBOutlet weak var dividerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.dotView.layer.cornerRadius = self.dotView.bounds.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
