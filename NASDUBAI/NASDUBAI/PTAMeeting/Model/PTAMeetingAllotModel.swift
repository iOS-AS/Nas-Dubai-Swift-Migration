//
//  PTAMeetingAllotModel.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 22/01/24.
//

import Foundation
struct PTMeetingAllotModel {
    
    
    fileprivate func SubmitData(_ studentID: String,_ ptaTimeSlotID: Int,_ staffId: String, completion: @escaping (String, Bool) -> ()) {
        
//        ApiServices().TimeSlotBooking(studentID: studentID, ptaTimeSlotId: ptaTimeSlotID, staffId: staffId) { (data) in
//            if data.status == 105 {
//                completion("Please pick a different date.", false)
//            }
//            if data.status == 136 {
//                completion("Date already registerd.", false)
//            }
//            if data.status == 100 || data.status == 112 {
//                completion("Succesfully submitted your request.", true)
//            }
//        }
    }
    
    func SubmitData(studentID: String, ptaTimeSlotID: Int, staffId: String, completion: @escaping (String, Bool) -> ()) -> String {
        SubmitData(studentID, ptaTimeSlotID, staffId, completion: completion)
        return ""
    }
    
//    fileprivate func cancelData(_ studentID: String,_ ptaTimeSlotID: Int,_ staffId: String, completion: @escaping (String, Bool) -> ()) {
//
//        ApiServices().TimeSlotCancel(studentID: studentID, ptaTimeSlotId: ptaTimeSlotID, staffId: staffId) { (data) in
//            if data.status == 105 {
//                completion("Please pick a different date.", false)
//            }
//            if data.status == 136 {
//                completion("Date already registerd.", false)
//            }
//            if data.status == 109 {
//                completion("Request cancelled successfully.", true)
//            }
//        }
//    }
    
    func cancelData(studentID: String, ptaTimeSlotID: Int, staffId: String, completion: @escaping (String, Bool) -> ()) -> String {
//        cancelData(studentID, ptaTimeSlotID, staffId, completion: completion)
        return ""
    }
    
}


// MARK: - PtaAllotData
struct PtaAllotData: Codable {
    let status: Int?
    let message: String?
    let data: PtaAllotObjectData?
}

// MARK: - DataClass
struct PtaAllotObjectData: Codable {
    let bookingID: Int?

    enum CodingKeys: String, CodingKey {
        case bookingID = "booking_id"
    }
}
