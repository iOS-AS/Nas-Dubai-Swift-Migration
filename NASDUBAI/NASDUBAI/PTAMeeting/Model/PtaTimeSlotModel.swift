//
//  PtaTimeSlotModel.swift
//  BISAD
//
//  Created by Amritha on 28/12/22.
//

import Foundation

struct PtaTimeSlotModel {
    
    func getData(studentId: String, staffId: String, date: String, completion: @escaping (PtaCalendar?) -> ()) {

//        ApiServices().getPtaTimeSlot(studentID: studentId, staffID: staffId, date: date) { (data) in
//            
//            completion(data)
////            if let a = data.response  {
////                completion(a)
////            } else {
////                completion(nil)
////            }
//        }
    }
    func processData(data: PtaTimeSlot?) -> (PtaTimeSlot?, APIError?) {
        if data?.status == 101 || data?.status == 102 {
            alertMessage.value = K.someErrorOccured
            return (nil, .requestFailed)
        } else if data?.status == 116 {
            return (nil, .tokenExpired)
        } else {
            return (data, nil)
        }
    }
    
}







//struct PtaTimeSlot: Codable {
//    var responsecode: String?
//    var response: PtaTimeSlotResponse?
//}
//
//
//struct PtaTimeSlotResponse: Codable {
//    var response: String?
//    var statusCode: String?
//    var data: [PtaTimeSlotResponseData]?
//}
//
//struct PtaTimeSlotResponseData: Codable {
//    var date : String?
//    var start_time: String?
//    var end_time : String?
//    var book_end_date : String?
//    var room : String?
//    var vpml : String?
//    var status : String?
//    var booking_open : String?
//}

// MARK: - PtaTimeSlot
struct PtaTimeSlot: Codable {
    let status: Int?
    let message: String?
    let dataCount: Int?
    let data: [PtaTimeSlotResponseDataArray]?

    enum CodingKeys: String, CodingKey {
        case status, message
        case dataCount = "data_count"
        case data
    }
}

// MARK: - PtaTimeSlotResponseDataArray
struct PtaTimeSlotResponseDataArray: Codable {
    let parentEveningID: Int?
    let meetingDate, bookingEndDate: String?
    let slotID: Int?
    let slotStartTime, slotEndTime, room: String?
    let vpml: String?
    let status: Int?
    let statusSlotMessage, bookingStatus: String?

    enum CodingKeys: String, CodingKey {
        case parentEveningID = "parent_evening_id"
        case meetingDate = "meeting_date"
        case bookingEndDate = "booking_end_date"
        case slotID = "slot_id"
        case slotStartTime = "slot_start_time"
        case slotEndTime = "slot_end_time"
        case room, vpml, status
        case statusSlotMessage = "status_slot_message"
        case bookingStatus = "booking_status"
    }
}
