//
//  PreorderModel.swift
//  BISAD
//
//  Created by Joel Leo on 17/02/23.
//

import Foundation
struct PreorderModel {
    
    func processData(data: PreorderData?) -> (PreorderData?, APIError?) {
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



// MARK: - PreorderForBISADData
struct PreorderData: Codable {
    var status: Int?
    var responseArray: PreorderResponseArrayData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case responseArray = "responseArray"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        if container.contains(.responseArray) {
            self.responseArray = try container.decodeIfPresent(PreorderResponseArrayData.self, forKey: .responseArray)
        }
    }
}

// MARK: - PreorderResponseArrayData
struct PreorderResponseArrayData: Codable {
    var data: [PreorderValueData]?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

// MARK: - PreorderValueData
struct PreorderValueData: Codable {
    var id: Int?
    var deliveryDate: String?
    var totalAmount: String?
    var status: Int?
    var cancellation_time_exceed: Int?
    var section: String?
    var canteenPreorderedItems: [PreorderItemsData]?
    var typeStatus: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case deliveryDate = "delivery_date"
        case totalAmount = "total_amount"
        case status = "status"
        case section = "section"
        case canteenPreorderedItems = "canteen_preordered_items"
        case cancellation_time_exceed = "cancellation_time_exceed"
        case typeStatus = "type_status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.deliveryDate = try container.decodeIfPresent(String.self, forKey: .deliveryDate)
        self.totalAmount = try container.decodeIfPresent(String.self, forKey: .totalAmount)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        self.section = try container.decodeIfPresent(String.self, forKey: .section)
        self.canteenPreorderedItems = try container.decodeIfPresent([PreorderItemsData].self, forKey: .canteenPreorderedItems)
        self.cancellation_time_exceed = try container.decodeIfPresent(Int.self, forKey: .cancellation_time_exceed)
        self.typeStatus = try container.decodeIfPresent(Int.self, forKey: .typeStatus)
    }
}

// MARK: - PreorderItemsData
struct PreorderItemsData: Codable {
    var id: Int?
    var item_id: Int?
    var qntyInt: Int?
    var itemStatus: Int?
    var item_total: Int?
    var itemName: String?
    var price: String?
    var description: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case item_id = "item_id"
        case qntyInt = "quantity"
        case itemStatus = "item_status"
        case item_total = "item_total"
        case itemName = "item_name"
        case price = "price"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.item_id = try container.decodeIfPresent(Int.self, forKey: .item_id)
        do {
            self.qntyInt = try container.decode(Int.self, forKey: .qntyInt)
        } catch DecodingError.typeMismatch {
            self.qntyInt = try Int(container.decode(String.self, forKey: .qntyInt))
        }
        self.itemStatus = try container.decodeIfPresent(Int.self, forKey: .itemStatus)
        self.item_total = try container.decodeIfPresent(Int.self, forKey: .item_total)
        self.itemName = try container.decodeIfPresent(String.self, forKey: .itemName)
        self.price = try container.decodeIfPresent(String.self, forKey: .price)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
    }
}
