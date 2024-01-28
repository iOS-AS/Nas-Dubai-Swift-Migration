//
//  StudentCell.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 22/01/24.
//

import UIKit

class StudentCell: UITableViewCell {

    @IBOutlet weak var classLbl: UILabel!
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var studentIcon: UIImageView!
    var element: StudentList! {
        didSet {
            NameLbl.text = element.name
            classLbl.text = element.section
            if element.photo != "" {
//                iconImageView.sd_setImage(with: URL(string: element.photo!), completed: nil)
                studentIcon.sd_setImage(with: URL(string: element.photo!), placeholderImage: UIImage(named: "studentIcon"))
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        studentIcon.setBlueBorder()    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
