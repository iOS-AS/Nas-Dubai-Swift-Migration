//
//  CartListModel.swift
//  BISAD
//
//  Created by Joel Leo on 17/02/23.
//

import Foundation
struct CartListModel {
    
    func processData(data: CartListForBISADData?) -> (CartListForBISADData?, APIError?) {
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



// MARK: - CartListForBISADData
struct CartListForBISADData: Codable {
    var status: Int?
    var responseArray: CartListResponseArrayData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case responseArray = "responseArray"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        if container.contains(.responseArray) {
            self.responseArray = try container.decodeIfPresent(CartListResponseArrayData.self, forKey: .responseArray)
        }
    }
}

// MARK: - CartListResponseArrayData
struct CartListResponseArrayData: Codable {
    var data: [CartListValueData]?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

// MARK: - CartListValueData
struct CartListValueData: Codable {
    var delivery_date: String?
    var total_amount: Int?
    var items: [CartListItemsData]?
    
    enum CodingKeys: String, CodingKey {
        case delivery_date = "delivery_date"
        case total_amount = "total_amount"
        case items = "items"
    }
}

// MARK: - CartListItemsData
struct CartListItemsData: Codable {
    var id: Int?
    var item_id: Int?
    var delivery_date: String?
    var quantity: Int?
    var price: String?
    var item_name: String?
    var item_image: String?
    var item_total: Int?
    var description: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case item_id = "item_id"
        case delivery_date = "delivery_date"
        case quantity = "quantity"
        case price = "price"
        case item_name = "item_name"
        case item_image = "item_image"
        case item_total = "item_total"
        case description = "description"
    }
}
