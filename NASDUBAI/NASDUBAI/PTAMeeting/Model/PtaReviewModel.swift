//
//  PtaReviewModel.swift
//  BISAD
//
//  Created by MOB-IOS-05 on 29/12/22.
//

import Foundation

struct PtaReviewModel {
    
    func processData(data: PtaReviewList?) -> (PtaReviewList?, APIError?) {
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



//struct PtaReviewList: Codable {
//    var responsecode: String?
//    var response: PtaReviewRequest?
//}
//
//
//struct PtaReviewRequest: Codable {
//    var response: String?
//    var statuscode: String?
//    var data: [PTAReviewListArray]?
//}
//
//struct PTAReviewListArray: Codable {
//
//    var id : Int?
//    var student_id: Int?
//    var student: String?
//    var student_photo: String?
//    var staff: String?
//    var staff_id: Int?
//    var date: String?
//    var start_time: String?
//    var end_time: String?
//    var room: String?
//    var vpml: String?
//    var class_name: String?
//    var status: String?
//    var book_end_date: String?
//    var booking_open: String?
//
//}

// MARK: - PtaReviewList
struct PtaReviewList: Codable {
    let status: Int?
    let message: String?
    let data: [PTAReviewListArray]?
}

// MARK: - Datum
struct PTAReviewListArray: Codable {
    let id, ptaTimeSlotID: Int?
    let studentID, student: String?
    let studentPhoto: String?
    let staffID: Int?
    let staff, date, startTime, endTime: String?
    let room: String?
    let vpml: String?
    let studentClass: String?
    let status: Int?
    let bookEndDate, translator, bookingOpen: String?

    enum CodingKeys: String, CodingKey {
        case id
        case ptaTimeSlotID = "pta_time_slot_id"
        case studentID = "student_id"
        case student
        case studentPhoto = "student_photo"
        case staffID = "staff_id"
        case staff, date
        case startTime = "start_time"
        case endTime = "end_time"
        case room, vpml
        case studentClass = "student_class"
        case status
        case bookEndDate = "book_end_date"
        case translator
        case bookingOpen = "booking_open"
    }
}
