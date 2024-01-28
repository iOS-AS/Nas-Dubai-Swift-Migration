//
//  StaffModel.swift
//  BISAD
//
//  Created by Mobatia Cathu 2 on 21/12/20.
//

import Foundation

struct StaffModel {
    func processData(data: Staff?) -> (Staff?, APIError?) {
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


struct StaffReEnroll: Codable {
    var status: Int?
}



//
//struct Staff: Codable {
//    var status: Int?
//    var responseArray: StaffResponseArray?
//}
//
//// MARK: - ResponseArray
//struct StaffResponseArray: Codable {
//    var staffList: [StaffList]?
//
//    enum CodingKeys: String, CodingKey {
//        case staffList = "staff_list"
//    }
//}
//
//// MARK: - StaffList
//struct StaffList: Codable {
//    var name, email, id, staffPhoto: String?
//    var role: String?
//    enum CodingKeys: String, CodingKey {
//        case name, email, id, role
//        case staffPhoto = "staff_photo"
//    }
//}

// MARK: - Welcome
struct Staff: Codable {
    let status: Int?
    let message: String?
    let data: [StaffList]?
}

// MARK: - Datum
struct StaffList: Codable {
    let id: Int?
    let name: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}
