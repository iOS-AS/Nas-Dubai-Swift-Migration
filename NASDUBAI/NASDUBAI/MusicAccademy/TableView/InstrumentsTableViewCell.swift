//
//  InstrumentsTableViewCell.swift
//  NAS
//
//  Created by Mobatia Mac on 14/08/23.
//  Copyright © 2023 AJITH. All rights reserved.
//

import UIKit

class InstrumentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var instrumentNameView: UIView!
    @IBOutlet weak var instrumentNameLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func initActions() {
        instrumentNameView.layer.cornerRadius = 10
        instrumentNameView.layer.masksToBounds = true
    }
}
