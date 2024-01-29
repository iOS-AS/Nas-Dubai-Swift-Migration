//
//  CanteenCard.swift
//  NAS
//
//  Created by Naveeth's on 14/07/21.
//

import Foundation
//import ObjectMapper
/*

class BasketModel : Mappable {

    var previous_orders_total : Int?
    var cart_totoal : Double?
    var total_items_in_cart : Int?
    var cart_details : [BasketDetail]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        previous_orders_total <- map["previous_orders_total"]
        cart_totoal <- map["cart_totoal"]
        total_items_in_cart <- map["total_items_in_cart"]
        cart_details <- map["cart_details"]
    }
}

class BasketDetail : Mappable {

    var delivery_date : String?
    var total_amount : Int?
    var items : [BasketItem]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        delivery_date <- map["delivery_date"]
        total_amount <- map["total_amount"]
        items <- map["items"]
    }
}

class BasketItem : Mappable {

    var id : Int?
    var item_id : Int?
    var item_name : String?
    var item_description : String?
    var item_status : Int?
    var portal : Int?
    private var price : String? {
        didSet {
            priceInDouble = Double(price ?? "0")
        }
    }
    var priceInDouble: Double?
    var quantity : Int? {
        didSet {
            self.item_total = Double(quantity ?? 0) * (priceInDouble ?? 0)
        }
    }
    var item_total : Double?
    var available_quantity : Int?

    var cancellation_time_exceed : Int?

    //Extra
    var typeOfAction: TypeOfAction?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        id <- map["id"]
        item_id <- map["item_id"]
        item_name <- map["item_name"]
        item_description <- map["item_description"]
        item_status <- map["item_status"]
        portal <- map["portal"]

        price <- map["price"]
        quantity <- map["quantity"]
        available_quantity <- map["available_quantity"]
        item_total <- map["item_total"]
        cancellation_time_exceed <- map["cancellation_time_exceed"]
        typeOfAction = .canteenItem
    }

    init() {

    }
}

*/

