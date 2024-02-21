//
//  MessageModel.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 31/01/24.
//

import Foundation

struct MessageModel {

    func getDetails(notificationId: String, completion: @escaping ((MessageDetailNotification?) -> ())) {
//        ApiServices().getMessagesDetails(notificationID: notificationId) { (data) in
//            completion(data.responseArray?.notification ?? nil)
        }
    
    func processData(data: Message?) -> (Message?, APIError?) {
        if data?.responsecode == "101" || data?.responsecode == "102" {
            alertMessage.value = K.someErrorOccured
            return (nil, .requestFailed)
        } else if data?.responsecode == "116" {
            return (nil, .tokenExpired)
        } else {
            return (data, nil)
        }
    }
    }


    

    func processData(data: MessageDetail?) -> (MessageDetail?, APIError?) {
        if data?.status == 101 || data?.status == 102 {
            alertMessage.value = K.someErrorOccured
            return (nil, .requestFailed)
        } else if data?.status == 116 {
            return (nil, .tokenExpired)
        } else {
            return (data, nil)
        }
    }





struct Message: Codable {
    var response: MessageArray?
    var responsecode: String?
}

// MARK: - ResponseArray
struct MessageArray: Codable {
    var latest_survey_timestamp: String?
    var statuscode: String?
    var survey: Int?
    var data: [NotificationModel]?
}

// MARK: - Notification
struct NotificationModel: Codable {
    var time_Stamp, read_unread_status, title, id: String?
    var alertType: String?

    enum CodingKeys: String, CodingKey {
        case time_Stamp = "time_Stamp"
        case read_unread_status = "read_unread_status"
        case title, id
        case alertType = "alert_type"
    }
}





struct MessageDetail: Codable {
    var responseArray: MessageDetailArray?
    var status: Int?
}

// MARK: - ResponseArray
struct MessageDetailArray: Codable {
    var notification: MessageDetailNotification?
}

// MARK: - Notification
struct MessageDetailNotification: Codable {
    var updatedAt, alertType, title, createdAt: String?
    var message, url: String?

    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated_at"
        case alertType = "alert_type"
        case title
        case createdAt = "created_at"
        case message
        case url
    }
}

