//
//  PtaConfirmModel.swift
//  BISAD
//
//  Created by Mobatia Mac on 29/12/22.
//

import Foundation


struct PtaConfirmModel {
    
    fileprivate func ReviewSubmitPtaConfirm( _ dataValue: String , _ completion: @escaping (String, Bool) -> ()) {
       
//        ApiServices().ReviewConfirmPta(dataValue: dataValue) { (data) in
//            if data.status == 105 {
//                completion("Please pick a different date.", false)
//            }
//            if data.status == 100 {
//                completion("Succesfully submitted your request.", true)
//            }
//            if data.status == 135 {
//                completion("This date is already confirmed", false)
//            }
//            if data.status == 134 {
//                completion("Date not found", false)
//            }
//        }
    }

    func sumitPtaConfirm(dataValue: String, completion: @escaping (String, Bool) -> ()) -> String {

        ReviewSubmitPtaConfirm( dataValue, completion)
        
        return ""
    }
    
    fileprivate func reviewCancelPtaConfirm( _ studentID: String , _ ptaTimeSlotId: Int, _ staffId: String, _ completion: @escaping (String, Bool) -> ()) {
       
//        ApiServices().ReviewCancelConfirmPta(studentID: studentID, ptaTimeSlotId: ptaTimeSlotId, staffId: staffId) { (data) in
//            if data.status == 105 {
//                completion("Please pick a different date.", false)
//            }
//            if data.status == 109 {
//                completion("Successfully cancelled appointment.", true)
//            }
//        }
    }

    func canceltPtaConfirm(_ studentID: String , _ ptaTimeSlotId: Int, _ staffId: String, completion: @escaping (String, Bool) -> ()) -> String {

        reviewCancelPtaConfirm(studentID, ptaTimeSlotId, staffId, completion)
        
        return ""
    }

}


struct ptaConfirm : Codable {
    var status: Int?
    var message: String?
}

