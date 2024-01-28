//
//  CartListResponse.swift
//  NAS
//
//  Created by Mobatia Technology on 29/08/20.
//  Copyright © 2020 AJITH. All rights reserved.
//

import UIKit

// MARK: - 1st CALL
class CartListResponse: NSObject {
    var status:Int = 0
    var error: Bool = false
    var response: CartListData = CartListData([:])
    init(_ dataDict: [String: Any]) {
        if let status = dataDict["status"] as? Int {
            self.status = status
        }
        self.error = (dataDict["Error"] != nil)
        if error == false{
            self.response = CartListData(dataDict["responseArray"] as? [String : Any] ?? [:])
        }
    }
}
// MARK: - Response
class CartListData: NSObject {
    var statuscode:String = ""
    var response:String = ""
    var student_id:String = ""
    var ordered_user_type:String = ""
    var parent_id:String = ""
    var previous_orders_total:Double = 0
    var previous_orders_total_String:String = ""
    var cart_totoal:Double = 0
    var total_items_in_cart:Int = 0
    var time_ExceedStatus:Int = 0
    var isPreviousTotalInt:Bool = false
    var staff_id:String = ""
    var data: [CartList] = []
    init(_ dictionary: [String: Any]) {
        self.staff_id = dictionary["staff_id"] as? String ?? ""
        self.parent_id = dictionary["parent_id"] as? String ?? ""
        self.ordered_user_type = dictionary["ordered_user_type"] as? String ?? ""
        self.student_id = dictionary["student_id"] as? String ?? ""
        self.total_items_in_cart = dictionary["total_items_in_cart"] as? Int ?? 0
        self.time_ExceedStatus = dictionary["time_exceed"] as? Int ?? 10
        if let status = dictionary["statuscode"] as? Int {
            self.statuscode = "\(status)"
        }else if let status = dictionary["statuscode"] as? String {
            self.statuscode = "\(status)"
        }
        self.previous_orders_total_String = "\(dictionary["cart_totoal"] ?? "0")"
        self.previous_orders_total_String = "\(dictionary["cart_totoal"] ?? "0")"
        if ((dictionary["previous_orders_total"] as? Int) != nil) {
            self.previous_orders_total = Double(dictionary["previous_orders_total"] as? Int ?? 0)
        }else{
            self.previous_orders_total = dictionary["previous_orders_total"] as? Double ?? 0
        }
        if ((dictionary["cart_totoal"] as? Int) != nil) {
            self.cart_totoal = Double(dictionary["cart_totoal"] as? Int ?? 0)
        }else{
            self.cart_totoal = dictionary["cart_totoal"] as? Double ?? 0
        }
        self.response          = dictionary["response"] as? String ?? ""
        let dataArray   = dictionary["data"] as? [[String:Any]] ?? []
        self.cart_totoal = 0
        self.total_items_in_cart = 0
        for i in 0..<dataArray.count{
            let cartListObj = CartList(dataArray[i])
            self.data.append(cartListObj)
            self.cart_totoal = self.cart_totoal + cartListObj.totalAmount
            let count = cartListObj.cartitemDetails.reduce(0) { result, partialValue in
                return result + partialValue.qntyInt
            }
            self.total_items_in_cart = self.total_items_in_cart + count
        }
        
    }
}
// MARK: - Data
class CartList: NSObject {
    var deliveryDate: String = ""
    var totalAmount: Double = 0
    var cartitemDetails : [CartItemData] = []
    init(_ dataDict: [String: Any]) {
        self.deliveryDate = dataDict["delivery_date"] as? String ?? ""
        self.totalAmount = dataDict["total_amount"] as? Double ?? 0
        let dataArray   = dataDict["items"] as? [[String:Any]] ?? []
        for i in 0..<dataArray.count{
            self.cartitemDetails.append(CartItemData(dataArray[i]))
        }
    }
}
// MARK: - Date Wise

class CartItemData: NSObject {
    var id:String = ""
    var itemID:Int = 0
    var quantity:String = ""
    var qntyInt:Int = 0
    var priceInt:Int = 0
    var price:String = ""
    var itemName:String = ""
    var itemDescription:String = ""
    var availableQuantity: Int = 0
    var availableQuantityString: String = ""
    var itemsImageArray :[String] = []
    var portal:String = ""
    var deliveryDate: String = ""
    var itemTotal: Double = 0
    init(_ dictionary: [String: Any]) {
        self.portal = dictionary["portal"] as? String ?? ""
        if let tempValue = dictionary["id"] as? Int {
            self.id = "\(tempValue)"
        }
        self.itemID = dictionary["item_id"] as? Int ?? 0
        self.deliveryDate = dictionary["delivery_date"] as? String ?? ""
        if let tempValue = dictionary["quantity"] as? Int {
            self.quantity = "\(tempValue)"
        }
        self.qntyInt = Int(self.quantity) ?? 0
        self.price = dictionary["price"] as? String ?? ""
        self.priceInt = Int(self.price) ?? 0
        self.itemTotal = dictionary["item_total"] as? Double ?? 0
        self.itemName = dictionary["item_name"] as? String ?? ""
        self.itemDescription = dictionary["item_description"] as? String ?? ""
        self.availableQuantityString = dictionary["available_quantity"] as? String ?? ""
        self.availableQuantity = Int(self.availableQuantityString) ?? Int.max
        let dataArray  = dictionary["item_image"] as? [String] ?? []
        for i in 0..<dataArray.count{
            self.itemsImageArray.append(dataArray[i])
        }
    }
}
func checkType (obj:Any) -> String {
    if obj is Int { return "Int" }
    else if obj is String { return "String" }
    else if obj is Double { return "Double" }
    else { return "Any" }
}

class PreorderCartData: NSObject {
    var studentId: String
    var orders: [PreorderCartOrderData]
    init(studentId: String, cartListData: CartListData) {
        self.studentId = studentId
        self.orders = []
        for(_, obj) in cartListData.data.enumerated() {
            self.orders.append(PreorderCartOrderData(cartList: obj))
        }
    }
}

class PreorderCartOrderData: NSObject {
    var delivery_date: String
    var items: [PreorderCartOrderItemsData]
    init(cartList: CartList) {
        self.delivery_date = cartList.deliveryDate
        self.items = []
        for(_, obj) in cartList.cartitemDetails.enumerated() {
            self.items.append(PreorderCartOrderItemsData(cartItemData: obj))
        }
    }
}

class PreorderCartOrderItemsData: NSObject {
    var id: Int
    var item_id: Int
//    var delivery_date: String
    var quantity: Int
    var price: String
    init(cartItemData: CartItemData) {
        self.id = Int(cartItemData.id) ?? 0
        self.item_id = cartItemData.itemID
//        self.delivery_date = cartItemData.deliveryDate
        self.quantity = cartItemData.qntyInt
        self.price = cartItemData.price
    }
}
