//
//  PTAReviewFinalCell.swift
//  BISAD
//
//  Created by MOB-IOS-05 on 29/12/22.
//

import UIKit

class PTAReviewFinalCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var confirmCancelButton: UIButton!
    @IBOutlet weak var confirmCancelNewButton: UIButton!
    @IBOutlet weak var sclass: UILabel!
    @IBOutlet weak var staff: UILabel!
    @IBOutlet weak var VpnLink: UIButton!
    @IBOutlet weak var reservedDate: UILabel!
    @IBOutlet weak var confirmCancellation: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var AddToCalendar: UILabel!
    @IBOutlet weak var vpmlLinkBttn: UIButton!
    @IBOutlet weak var confirmImageView: UIImageView!
    @IBOutlet weak var statusImageView: UIImageView!
    
    @IBOutlet weak var vpnView: UIView!
    
    @IBOutlet weak var vpmHeight: NSLayoutConstraint!
    
    @IBOutlet weak var ptaCancelImg: UIImageView!
    var onSubmitAction: (Int) -> (Void) = { _ in }
    var indexValue: Int = 0
    
    var onCancelAction: (Int) -> (Void) = { _ in }
    var indexValueCancel: Int = 0
    
    var onVpmlAction: (Int) -> (Void) = { _ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vpnView.isHidden = true
        confirmCancelNewButton.setTitle("", for: .normal)
        vpmlLinkBttn.setTitle("", for: .normal)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //vpnView.isHidden = true
        // Configure the view for the selected state
    }
    
}


extension PTAReviewFinalCell {
    @IBAction func submitAction(_ sender: Any) {
        
        self.onSubmitAction(indexValue)
    }
}


extension PTAReviewFinalCell {
    @IBAction func CancelAction(_ sender: Any) {
        self.onCancelAction(indexValue)
    }
    
}


extension PTAReviewFinalCell {
    @IBAction func onVpmlAction(_ sender: Any) {
        self.onVpmlAction(indexValue)
    }
    
}


