//
//  EarlyListModel.swift
//  BISAD
//
//  Created by Joel Leo on 26/03/23.
//

import Foundation
struct EarlyListModel {
    
    func processData(data: EarlyListData?) -> (EarlyListData?, APIError?) {
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



// MARK: - EarlyListData
struct EarlyListData: Codable {
    var status: Int?
    var responseArray: EarlyListValueData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case responseArray = "responseArray"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        if container.contains(.responseArray) {
            self.responseArray = try container.decodeIfPresent(EarlyListValueData.self, forKey: .responseArray)
        }
    }
}

// MARK: - EarlyListValueData
struct EarlyListValueData: Codable {
    var data: [EarlyListValueDataItem]?
    var bannerImage: String?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case bannerImage = "banner_image"

    }
}

// MARK: - EarlyListValueData
struct EarlyListValueDataItem: Codable {
    var name: String?
    var id: Int?
    var file: [EarlyListValueFile]?

    enum CodingKeys: String, CodingKey {
//        case id = "id"
        case name = "name"
        case id = "id"
        case file = "file"
    }
}

// MARK: - EarlyListValueData
struct EarlyListValueFile: Codable {
    var description: String?
    var title: String?
    var id: Int?
    var file: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case title = "title"
        case id = "id"
        case file = "file"
        case url = "url"
    }
}
