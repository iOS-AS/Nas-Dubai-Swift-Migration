//
//  InstrumentPaymentSummaryTableViewCell.swift
//  NAS
//
//  Created by Joel Leo on 18/08/23.
//  Copyright © 2023 AJITH. All rights reserved.
//

import UIKit

class InstrumentPaymentSummaryTableViewCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subValue1Label: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var arrowImageContainer: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
