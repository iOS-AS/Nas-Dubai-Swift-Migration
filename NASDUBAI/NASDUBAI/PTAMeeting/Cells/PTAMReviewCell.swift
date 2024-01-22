//
//  PTMReviewCell.swift
//  NAS
//
//  Created by Naveeth's on 09/06/21.
//

import UIKit

protocol PTMReviewCellDelegate {
    //func ptMReviewCellActions(_ typeOfAction: TypeOfAction?, _ item: TimeSlotModel?)
}

class PTMReviewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var stackView: UIStackView!
    
    

    @IBOutlet weak var thumbnailImgView: UIImageView!
    //1.name 2.class
    @IBOutlet weak var Name: UILabel!
    
    
    
    
    @IBOutlet weak var `class`: UILabel!
    
    
    
    @IBOutlet weak var staff: UILabel!
    

    
    
    
    @IBOutlet weak var reserveDateTimeLbl: UILabel!
    @IBOutlet weak var confirmCancelLbl: UILabel!
    //
    @IBOutlet weak var addCalendarImgView: UIImageView!
    @IBOutlet weak var addCalendarLbl: UILabel!

    @IBOutlet weak var statusImgView: UIImageView!
    @IBOutlet weak var cancelImgView: UIImageView!
    @IBOutlet weak var cancelLbl: UILabel!

    @IBOutlet weak var addCalendarView: UIView!
    @IBOutlet weak var cancelView: UIView!

    @IBOutlet weak var topviewHt: NSLayoutConstraint!

    @IBOutlet weak var vpmlBtn: UIButton!

    @IBOutlet weak var bottomViewHt: NSLayoutConstraint!
    //private var data: TimeSlotModel?

    var delegate: PTMReviewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        addCalendarView.isHidden = true
//        addCalendarView.isUserInteractionEnabled = false

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func vpmlPressed(_ sender: Any) {
        //        guard let link = data?.vpml, link.count > 0 else { return }
       // delegate?.ptMReviewCellActions(.joinMeeting, data)
    }

    func updateAddCalendarUI(imageName: String, tit: String, alpha: CGFloat) {

        addCalendarImgView.image = UIImage(named: imageName)
        addCalendarLbl.text = tit

        addCalendarImgView.alpha = alpha
        addCalendarLbl.alpha = alpha

        addCalendarView.isUserInteractionEnabled = alpha == 1.0
    }

    func updateCancelUI(alpha: CGFloat) {

        cancelImgView.alpha = alpha
        cancelLbl.alpha = alpha

        cancelView.isUserInteractionEnabled = alpha == 1.0
    }

    func setupGesture() {

        let calendarGesture = UITapGestureRecognizer(target: self, action: #selector(viewPressed))
        calendarGesture.numberOfTouchesRequired = 1
        addCalendarView.addGestureRecognizer(calendarGesture)

        let cancelGesture = UITapGestureRecognizer(target: self, action: #selector(viewPressed))
        cancelGesture.numberOfTouchesRequired = 1
        cancelView.addGestureRecognizer(cancelGesture)
    }

    @objc func viewPressed(_ sender: UITapGestureRecognizer?) {

        guard let senderView = sender?.view else { return }

//        if senderView == addCalendarView {
//            if addCalendarLbl.text == DefaultValue.confirm {
//                delegate?.ptMReviewCellActions(.reviewConfirm, data)
//            } else if addCalendarLbl.text == DefaultValue.addToCalendar {
//                delegate?.ptMReviewCellActions(.add, data)
//            }
//        } else if senderView == cancelView {
//            delegate?.ptMReviewCellActions(.cancel, data)
//        }
    }

//    func configure(_ data: TimeSlotModel?) {
//
//        guard let item = data else { return }
//        self.data = item
//        setupGesture()
//
//        studentsLbl.first?.attributedText = getAttributeValue(attr_1: DefaultValue.student, attr_2: item.student ?? "", appendValue: ":  ")
//        studentsLbl.last?.attributedText = getAttributeValue(attr_1: DefaultValue.classKey, attr_2: item.student_class ?? "", appendValue: ":  ")
//        staffNameLbl.attributedText = getAttributeValue(attr_1: DefaultValue.staff, attr_2: item.staff ?? "", appendValue: ":  ")
//
//        //Reserved date
//        let date = item.date?.getFormattedDate(currentFomat: DateFormatterType.yyyy_MM_dd, expectedFromat: DateFormatterType.dd_MM_yyyy)
//        let formattedStartTime = (date ?? "") + " " + (item.formattedStartTime ?? "")
//        let formattedEndTime = " - " + (item.formattedEndTime ?? "")
//        let formattedDate = formattedStartTime + formattedEndTime
//        reserveDateTimeLbl.setAttribute(values: [DefaultValue.reserved_date_time, formattedDate], stringSpacings: [":  ", ""], lineSpacings: [0.0, 0.0], colors: [.black, .black], fonts: [AppVariable.shared.appFontWithSize(type: .Regular, size: 3.0), AppVariable.shared.appFontWithSize(type: .Semibold, size: 3.0)])
//
//        //        reserveDateTimeLbl.attributedText = getAttributeValue(attr_1: DefaultValue.reserved_date_time, attr_2: formattedDate, appendValue: ":  ")
//
//        //ConfirmCancel Date
//        let cancelFont = AppVariable.shared.appFontWithSize(type: .Regular, size: 3.0)
//        let cancelText = DefaultValue.confirmCancellationClose + (data?.formattedBookEndDate ?? "")
//        confirmCancelLbl.setAttribute(values: [cancelText], stringSpacings: [""], lineSpacings: [0.0], colors: [.errorColor()], fonts: [cancelFont])
//
//        //student Photo
//        if let url = URL(string: item.student_photo ?? "")  {
//            thumbnailImgView.loadImage(url: url, placeHolder: UIImage(named: ImageName.student), showProgress: false) { image in
//            }
//        }
//
//        //Update Cancel Image
//        updateCancelUI(alpha: 1.0)
//        var confirm_alpha: CGFloat?
//        if data?.booking_open == "n" {
//            updateCancelUI(alpha: 0.5)
//            updateAddCalendarUI(imageName: ImageName.confirm, tit: DefaultValue.confirm, alpha: 0.5)
//            confirm_alpha = 0.5 //Set confirm alpha
//        } else {
//            updateCancelUI(alpha: 1.0)
//            updateAddCalendarUI(imageName: ImageName.confirm, tit: DefaultValue.confirm, alpha: 1.0)
//            confirm_alpha = 1.0 //Set confirm alpha
//        }
//
//        //Update Status Image
//        if data?.slotStatus == .slotBooked {
//            statusImgView.image = UIImage(named: ImageName.participate)
//            updateAddCalendarUI(imageName: ImageName.add_to_calednar, tit: DefaultValue.addToCalendar, alpha: 1.0)
//        } else {
//            statusImgView.image = UIImage(named: ImageName.doubt_participate)
//            updateAddCalendarUI(imageName: ImageName.confirm, tit: DefaultValue.confirm, alpha: confirm_alpha ?? 0.0)
//        }
//
//        //Update VPML Button
//        if let link = data?.vpml, link.count > 0, data?.slotStatus == .slotBooked {
//            vpmlBtn.isHidden = false
//            vpmlBtn.isUserInteractionEnabled = true
//        } else {
//            vpmlBtn.isHidden = true
//            vpmlBtn.isUserInteractionEnabled = false
//        }
//
//        let topView = (SCREEN_HEIGHT * 0.09)
//        let bottomView = (SCREEN_HEIGHT * 0.055)
//        //Set TopViewHt
//        topviewHt.constant = topView
//        bottomViewHt.constant = bottomView
//        contentView.layoutIfNeeded()
//    }
//
//    func getAttributeValue(attr_1: String, attr_2: String, appendValue: String) -> NSAttributedString {
//
//        let attributeStringValues = NSAttributedString.setAttributedText(range_1: attr_1, range_1FontType: .Regular, range_1FontSize: 3.0, range_1Color: .black, range_1AppendValue: appendValue, range_2: attr_2, range_2FontType: .Semibold, range_2FontSize: 3.0, range_2Color: .black, range_2AppendValue: "")
//
//        let output = attributeStringValues.0
//
//        return output
//    }
}
