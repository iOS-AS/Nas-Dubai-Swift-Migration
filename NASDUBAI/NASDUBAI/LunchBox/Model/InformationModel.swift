//
//  InformationModel.swift
//  BISAD
//
//  Created by Joel Leo on 17/02/23.
//

import Foundation
struct InformationModel {
    
    func processData(data: InformationData?) -> (InformationData?, APIError?) {
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



// MARK: - InformationData
struct InformationData: Codable {
    var status: Int?
    var responseArray: InformationResponseArrayData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case responseArray = "responseArray"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        if container.contains(.responseArray) {
            self.responseArray = try container.decodeIfPresent(InformationResponseArrayData.self, forKey: .responseArray)
        }
    }
}

// MARK: - InformationResponseArrayData
struct InformationResponseArrayData: Codable {
    var information: [InformationResponseDataItem]?

    enum CodingKeys: String, CodingKey {
        case information = "information"
    }
}

// MARK: - InformationResponseArrayData
struct InformationResponseDataItem: Codable {
    var id: Int?
    var title: String?
    var file: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case file = "file"
    }
}
