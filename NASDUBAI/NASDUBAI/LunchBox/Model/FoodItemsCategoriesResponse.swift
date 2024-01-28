//
//  FoodItemsCategoriesResponse.swift
//  NAS
//
//  Created by Mobatia Technology on 28/08/20.
//  Copyright © 2020 AJITH. All rights reserved.
//

import Foundation
import UIKit

class FoodItemsCategoriesResponse: NSObject {
    var status:Int = 0
    var error: Bool = false
    var response: ItemsCategoriesResponse = ItemsCategoriesResponse([:])
    init(_ dataDict: [String: Any]) {
        if let status = dataDict["status"] as? Int {
            self.status = status
        }
        self.error = (dataDict["Error"] != nil)
        if error == false{
            self.response = ItemsCategoriesResponse(dataDict["responseArray"] as? [String : Any] ?? [:])
        }
    }
}
class ItemsCategoriesResponse: NSObject {
    var data: [ItemsCategoriesList] = []
    init(_ dictionary: [String: Any]) {
        let dataArray   = dictionary["data"] as? [[String:Any]] ?? []
        for i in 0..<dataArray.count{
            self.data.append(ItemsCategoriesList(dataArray[i]))
        }
    }
}
class ItemsCategoriesList: NSObject {
    var id: Int?
    var category_name: String = ""
    var category_image: String = ""
    var isSelected: String = "0"
    
    init(_ dataDict: [String: Any]) {
        self.id = dataDict["id"] as? Int
        self.category_name = dataDict["category_name"] as? String ?? ""
        self.category_image = dataDict["category_image"] as? String ?? ""
    }
}
