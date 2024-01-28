//
//  PaymentBannerModel.swift
//  BISAD
//
//  Created by Joel Leo on 15/02/23.
//

import Foundation
struct PaymentBannerModel {
    
    func processData(data: PaymentBannerData?) -> (PaymentBannerData?, APIError?) {
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



// MARK: - PaymentBannerData
struct PaymentBannerData: Codable {
    var status: Int?
    var responseArray: PaymentBannerValueData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case responseArray = "responseArray"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        if container.contains(.responseArray) {
            self.responseArray = try container.decodeIfPresent(PaymentBannerValueData.self, forKey: .responseArray)
        }
    }
}

// MARK: - PaymentBannerValueData
struct PaymentBannerValueData: Codable {
    var data: PaymentBannerValueDataItem?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

// MARK: - PaymentBannerValueData
struct PaymentBannerValueDataItem: Codable {
//    var id: Int?
    var image: String?
    var description: String?
    var contactEmail: String?
    var facebookUrl: String?
    var wallet_topup_limit: String?
    var trn_no: String?

    enum CodingKeys: String, CodingKey {
//        case id = "id"
        case image = "image"
        case description = "description"
        case contactEmail = "contact_email"
        case facebookUrl = "facebook_url"
        case wallet_topup_limit = "wallet_topup_limit"
        case trn_no = "trn_no"
    }
}
