//
//  PTMTimeSlotCell.swift
//  BISAD
//
//  Created by Amritha on 28/11/22.
//

import UIKit

class PTMTimeSlotCell: UICollectionViewCell {
    @IBOutlet weak var fromTimeLbl: UILabel!
    @IBOutlet weak var fromAmPMLbl: UILabel!
    @IBOutlet weak var toTimeLbl: UILabel!
    @IBOutlet weak var toAmPMLbl: UILabel!
    @IBOutlet weak var outerView: UIView!
    
    @IBOutlet weak var seperateImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    
    
    
    
    
//    private func setTextColor(color: UIColor?) {
//
//        guard let text_color = color else { return }
//        let _ = [fromTimeLbl, fromAmPMLbl, toTimeLbl, toAmPMLbl].map( { $0?.textColor = text_color })
//        if text_color == .bgColor() {
//            seperateImgView.image = UIImage(named: ImageName.seperate_white)
//        } else {
//            seperateImgView.image = UIImage(named: ImageName.seperate_black)
//        }
//    }
//
//    func configure(_ data: TimeSlotModel?) {
//
//        guard let item = data else { return }
////        setTextColor(color: .black)
//
//        if let st = item.formattedStartTime, st.count == 8 {
//            fromTimeLbl.text = String(st.prefix(5))
//            fromAmPMLbl.text = String(st.suffix(2))
//        }
//
//        if let et = item.formattedEndTime, et.count == 8 {
//            toTimeLbl.text = String(et.prefix(5))
//            toAmPMLbl.text = String(et.suffix(2))
//        }
//
//        /*
//         if item.status == 1 {
//         outerView.backgroundColor = .placeholderColor()
//         outerView.borderColor = .clear
//         } else if item.status == 3 {
//         outerView.backgroundColor = .secondaryColor()
//         outerView.borderColor = .clear
//         setTextColor(color: .bgColor())
//         } else {
//         if item.isAlreadySelected == true {
//         outerView.backgroundColor = .appThemeColor()
//         setTextColor(color: .bgColor())
//         } else {
//         outerView.backgroundColor = .bgColor()
//         }
//         outerView.borderColor = .appThemeColor()
//         }
//         */
//
//        guard let slotStatus = item.slotStatus else { return }
//        switch slotStatus {
//
//        case .slotNotAvailable:
//            outerView.backgroundColor = .placeholderColor()
//            outerView.borderColor = .clear
//            setTextColor(color: .titleColor())
//
//        case .slotAvailable:
//            outerView.backgroundColor = .bgColor()
//            outerView.borderColor = .appThemeColor()
//            setTextColor(color: .titleColor())
//
//        case .slotNotConfirmed:
//            outerView.backgroundColor = .appThemeColor()
//            outerView.borderColor = .appThemeColor()
//            setTextColor(color: .bgColor())
//
//        case .slotBooked:
//            outerView.backgroundColor = .secondaryColor()
//            outerView.borderColor = .clear
//            setTextColor(color: .bgColor())
//        }
//    }
}
