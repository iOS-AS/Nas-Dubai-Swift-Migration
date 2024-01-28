//
//  FoodModel.swift
//  NAS
//
//  Created by Naveeth's on 28/05/21.
//

import UIKit
import ObjectMapper

class FoodModel : Mappable {
    
    var id : Int?
    var item_name : String?
    var available_date : String?
    var available_quantity : Int?
    var unit : String?
    var bar_code : String?
    var profit_margin : String?
    var price : Double?
    var barcode_qty : Int?
    var description : String?
    var item_category_id : Int?
    var status : Int?
    var item_already_ordered : Int?
    var student_id : Int? //Current not getting student_id from API. But it is required for filter the card details by student

    //Extra values
    var totalAddedQuantity: Int? {
        didSet {
            if totalAddedQuantity == 0 {
                self.totalPrice = 1.0 * (price ?? 0)
            } else {
                self.totalPrice = Double(totalAddedQuantity ?? 0) * (price ?? 0)
            }
        }
    }
    var totalPrice: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        item_name <- map["item_name"]
        available_date <- map["available_date"]
        available_quantity <- map["available_quantity"]
        unit <- map["unit"]
        bar_code <- map["bar_code"]
        profit_margin <- map["profit_margin"]
        price <- map["price"]
        barcode_qty <- map["barcode_qty"]
        description <- map["description"]
        item_category_id <- map["item_category_id"]
        status <- map["status"]
        item_already_ordered <- map["item_already_ordered"]
        student_id <- map["student_id"]
        //
        totalAddedQuantity = 0
        //        let pr = (price ?? 0)
        //        totalPrice = 1.0 * pr
    }
    
}
