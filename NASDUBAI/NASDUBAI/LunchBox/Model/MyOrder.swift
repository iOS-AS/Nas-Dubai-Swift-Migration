//
//  MyOrder.swift
//  NAS
//
//  Created by Naveeth's on 14/07/21.
//

import Foundation
import ObjectMapper
/*

class MyOrder : Mappable {

    var whole_total : Double?
    var canteen_preorders : [CanteenPreOrders]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        whole_total <- map["whole_total"]
        canteen_preorders <- map["canteen_preorders"]
    }
}

class CanteenPreOrders : Mappable {

    var id : Int?
    var delivery_date : String?
    var total_amount : Double?
    var status : Int?
    var cancellation_time_exceed : Int?
    var classroom_number : String?
    var pickup_location : String?
    var items : [BasketItem]?

//    var totalPrice: Double?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        id <- map["id"]
        delivery_date <- map["delivery_date"]
        total_amount <- map["total_amount"]
        status <- map["status"]
        cancellation_time_exceed <- map["cancellation_time_exceed"]
        classroom_number <- map["classroom_number"]
        pickup_location <- map["pickup_location"]
        items <- map["canteen_preordered_items"]

//        totalPrice = Double(total_amount ?? "") ?? 0
    }
}
*/
/*
class CanteenPreOrderedItems : Mappable {

    var id : Int?
    var item_id : Int?
    var quantity : Int?
    var portal : Int?
    var item_status : Int?
    var item_total : Double?
    var item_name : String?
    var price : String?
    var available_quantity : Int?
    var item_description : String?
    var cancellation_time_exceed : Int?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        id <- map["id"]
        item_id <- map["item_id"]
        quantity <- map["quantity"]
        portal <- map["portal"]
        item_status <- map["item_status"]
        item_total <- map["item_total"]
        item_name <- map["item_name"]
        price <- map["price"]
        available_quantity <- map["available_quantity"]
        item_description <- map["item_description"]
        cancellation_time_exceed <- map["cancellation_time_exceed"]
    }
}
*/
