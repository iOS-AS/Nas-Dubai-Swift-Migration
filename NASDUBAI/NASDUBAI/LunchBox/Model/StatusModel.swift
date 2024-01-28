//
//  StatusModel.swift
//  BISAD
//
//  Created by Joel Leo on 17/02/23.
//

import Foundation
struct StatusModel {
    
    func processData(data: StatusData?) -> (StatusData?, APIError?) {
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



// MARK: - StatusData
struct StatusData: Codable {
    var status: Int?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
    }
}
