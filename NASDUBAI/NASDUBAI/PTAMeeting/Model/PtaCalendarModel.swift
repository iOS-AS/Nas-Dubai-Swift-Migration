//
//  PtaCalendarModel.swift
//  BISAD
//
//  Created by Amritha on 26/12/22.
//

import Foundation


struct PtaCalendarModel {
    
    func getData(studentId: String, staffId: String, completion: @escaping (PtaCalendar?) -> ()) {

        ApiServices().getPtaCalendar(studentID: studentId, staffID: staffId) { (data) in
            
            completion(data)
//            if let a = data  {
//                completion(a)
//            } else {
//                completion(nil)
//            }
        }
    }
    
    func processData(data: PtaCalendar?) -> (PtaCalendar?, APIError?) {
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


//struct PtaCalendar: Codable {
//    var responsecode: String?
//    var response: PtaCalendarResponse?
//}
//
//
//struct PtaCalendarResponse: Codable {
//    var response: String?
//    var statusCode: String?
//    var data:[String]?
//}


//// MARK: - PTA CALENDAR
//
struct PtaCalendar: Codable {
    let status: Int
    let message: String
    let data: [String]?
}
