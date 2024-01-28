//
//  PTASubmitConfirmModel.swift
//  BISAD
//
//  Created by Mobatia Mac on 21/07/23.
//

import Foundation



struct  PTASubmitConfirm {
    
    fileprivate func submitConfirmPTA( _ dataValue: String , _ completion: @escaping (String, Bool) -> ()) {
       
        ApiServices().sumitReEnrollment(dataValue: dataValue) { (data) in
            if data.status == 105 {
                completion("Please pick a different date.", false)
            }
            if data.status == 100 {
                
                completion("Succesfully submitted your request.", true)
            }
        }
    }

    func submitConfirmPTA(dataValue: String, completion: @escaping (String, Bool) -> ()) -> String {

        submitConfirmPTA( dataValue, completion)
        
        return ""
    }
    
    
    func processData(data: PTASubmitConfirmModel?) -> (PTASubmitConfirmModel?, APIError?) {
        
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
    

// MARK: - Welcome
struct PTASubmitConfirmModel: Codable {
    let status: Int?
    let message: String?
    let data: PTASubmitResponseDict?
}

// MARK: - DataClass
struct PTASubmitResponseDict: Codable {
    let errors: [ErrorArray]?
}

// MARK: - Error
struct ErrorArray: Codable {
    let ptaTimeSlotBookingID: Int?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case ptaTimeSlotBookingID = "pta_time_slot_booking_id"
        case status
    }
}


