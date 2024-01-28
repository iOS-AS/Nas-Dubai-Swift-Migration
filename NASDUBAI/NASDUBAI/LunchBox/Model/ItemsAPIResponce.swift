//
//  ItemsAPIResponce.swift
//  NAS
//
//  Created by Mobatia Technology on 10/09/20.
//  Copyright © 2020 AJITH. All rights reserved.
//

import Foundation
class ItemsAPIResponce: NSObject {
    var status:Int = 0
    var error: Bool = false
    var response: ItemsResponse = ItemsResponse([:])
    init(_ dataDict: [String: Any]) {
        if let status = dataDict["status"] as? Int {
            self.status = status
        }
        self.error = (dataDict["Error"] != nil)
        if error == false{
            self.response = ItemsResponse(dataDict["responseArray"] as? [String : Any] ?? [:])
        }
    }
}
class ItemsResponse: NSObject {
    var data: [ItemList] = []
    init(_ dictionary: [String: Any]) {
        let dataArray = dictionary["data"] as? [[String:Any]] ?? []
        for i in 0..<dataArray.count{
            self.data.append(ItemList(dataArray[i]))
        }
    }
}
class ItemsData: NSObject {
    var date: String = ""
    var itemsCountInCategory: Int = 0
    var isClicked: String = "0"
    var isItemSelected: String = "0"
    var dayIndication: String = ""
    var items : [ItemList] = []
    //    "details": []
    init(_ dataDict: [String: Any]) {
        self.date = dataDict["date"] as? String ?? ""
        self.itemsCountInCategory = dataDict["items_count_in_category"] as? Int ?? 0
        let dataArray   = dataDict["items"] as? [[String:Any]] ?? []
        for i in 0..<dataArray.count{
            self.items.append(ItemList(dataArray[i]))
        }
    }
}
class ItemList: NSObject {
    var id: Int?
    var alreadyIncart: String = "0"
    var itemName: String = ""
    var availableDate: String = ""
    var unit: String = ""
    var barCode: String = ""
    var profitMargin: String = ""
    var price: String = ""
    var barcodeQty: String = ""
    var itemCategoryID: String = ""
//    var status: String = ""
    var quantity: String = "1"
    var qntyInt: Int = 0
    var itemImage: String = ""
    var itemDescription: String = ""
    var availableQuantityString: String = ""
    var cartID: String = ""
    var itemAlredyOrder: String = ""
    var availableQuantity: Int = 0
    var itemsImageArray :[String] = []
    var priceAED: String = "AED"
    init(_ dataDict: [String: Any]) {
        self.id = dataDict["id"] as? Int
        self.itemName = dataDict["item_name"] as? String ?? ""
        self.availableDate = dataDict["available_date"] as? String ?? ""
        self.unit = dataDict["unit"] as? String ?? ""
        self.barCode = dataDict["bar_code"] as? String ?? ""
        self.profitMargin = dataDict["profit_margin"] as? String ?? ""
        self.price = dataDict["price"] as? String ?? ""
        self.barcodeQty = dataDict["barcode_qty"] as? String ?? ""
        self.itemCategoryID = dataDict["litem_category_idass"] as? String ?? ""
//        self.status = dataDict["status"] as? String ?? ""
        self.itemImage = dataDict["item_image"] as? String ?? ""
        self.itemDescription = dataDict["description"] as? String ?? ""
        self.availableQuantityString = dataDict["available_quantity"] as? String ?? "100"
        self.priceAED = "\(self.price) \(priceAED)"
        self.qntyInt = Int(self.quantity) ?? 0
        if let tempValue = dataDict["item_already_ordered"] as? Int {
            self.itemAlredyOrder = "\(tempValue)"
        }
        self.availableQuantity = Int(self.availableQuantityString) ?? 0
        let dataArray  = dataDict["item_image"] as? [String] ?? []
        for i in 0..<dataArray.count{
            self.itemsImageArray.append(dataArray[i])
        }
    }
}
