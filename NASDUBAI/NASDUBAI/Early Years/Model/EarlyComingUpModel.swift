//
//  EarlyComingUpModel.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 18/01/24.
//

import Foundation
struct EarlyComingUpModel {
    
    func processData(data: EarlyComingUpData?) -> (EarlyComingUpData?, APIError?) {
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



// MARK: - EarlyComingUpData
struct EarlyComingUpData: Codable {
    var status: Int?
    var responseArray: EarlyComingUpValueData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case responseArray = "responseArray"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        if container.contains(.responseArray) {
            self.responseArray = try container.decodeIfPresent(EarlyComingUpValueData.self, forKey: .responseArray)
        }
    }
}

// MARK: - EarlyComingUpValueData
struct EarlyComingUpValueData: Codable {
    var data: [EarlyComingUpValueDataItem]?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

// MARK: - EarlyComingUpValueData
struct EarlyComingUpValueDataItem: Codable {
    var dateString: String?
    var title: String?
    var description: String?
    var image: String?
    var status: String?
    
    enum CodingKeys: String, CodingKey {
        case dateString = "date"
        case title = "title"
        case description = "description"
        case image = "image"
        case status = "status"
    }
}

