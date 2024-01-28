//
//  SummaryModel.swift
//  NAS
//
//  Created by MOB-IOS-05 on 12/08/23.
//  Copyright © 2023 AJITH. All rights reserved.
//

import UIKit
// MARK: - 1st CALL
class InstrumentOrderResponseModel: NSObject {
    var responsecode:String = ""
    var response: InstrumentOrderResponse = InstrumentOrderResponse([:])
    var error: Bool = false
    init(_ dataDict: [String: Any]) {
        if let status = dataDict["responsecode"] as? Int {
            self.responsecode = "\(status)"
        }else if let status = dataDict["responsecode"] as? String {
            self.responsecode = "\(status)"
        }
        self.error = (dataDict["Error"] != nil)
        if error == false{
            self.response = InstrumentOrderResponse(dataDict["response"] as? [String : Any] ?? [:])
        }
    }
}
// MARK: - Response
class InstrumentOrderResponse: NSObject {
    var statuscode:String = ""
    var response:String = ""
    var data: InstrumentOrderData = InstrumentOrderData([:])
    init(_ dictionary: [String: Any]) {
       
        if let status = dictionary["statuscode"] as? Int {
            self.statuscode = "\(status)"
        }else if let status = dictionary["statuscode"] as? String {
            self.statuscode = "\(status)"
        }
        self.response = dictionary["response"] as? String ?? ""
        self.data = InstrumentOrderData(dictionary["data"] as? [String:Any] ?? [:])
    }
}
class InstrumentOrderData: NSObject{
    var instrument_data: [InstrumentOrderListData] = []
    init(_ dict:[String:Any]) {
        let dataList = dict["instrument_data"] as? [[String:Any]] ?? []
        for i in 0..<dataList.count{
            self.instrument_data.append(InstrumentOrderListData(dataList[i]))
        }
    }
}
class InstrumentOrderListData: NSObject {
    var id:Int
    var intrument_name:String = ""
    var order_data: [OrderData] = []
    init(_ dictionary: [String: Any]) {
        
        self.id = dictionary["instrument_id"] as? Int ?? 0
        self.intrument_name = dictionary["instrument_name"] as? String ?? ""
        let dataList = dictionary["order_data"] as? [[String:Any]] ?? []
        self.order_data = []
        for i in 0..<dataList.count{
            self.order_data.append(OrderData(dataList[i]))
        }
       
        
    }
}
class OrderData: NSObject{
    var order_id:Int
    var order_reference:String = ""
    var student_id:String = ""
    var instrument_id:Int = 0
    var lesson_id:Int = 0
    var lesson_name:String = ""
    var term_id:Int = 0
    var term_name:String = ""
    var learning_level:String = ""
    var learning_level_status:String = ""
    var amount:String = ""
    var currency:String = ""
    var tax_type:String = ""
    var tax_amount:String = ""
    var tax_percentage:String = ""
    var total_amount: String = ""
    var status: String = ""
    init(_ dictionary: [String: Any]) {
        self.order_id = dictionary["order_id"] as?
        Int ?? 0
        self.order_reference = dictionary["order_reference"] as?
        String ?? ""
        self.student_id = dictionary["student_id"] as?
        String ?? ""
        self.instrument_id = dictionary["instrument_id"] as?
        Int ?? 0
        self.lesson_id = dictionary["lesson_id"] as?
        Int ?? 0
        self.lesson_name = dictionary["lesson_name"] as?
        String ?? ""
        self.term_id = dictionary["term_id"] as?
        Int ?? 0
        self.term_name = dictionary["term_name"] as?
        String ?? ""
        self.learning_level = dictionary["learning_level"] as?
        String ?? ""
        self.learning_level_status = dictionary["learning_level_status"] as?
        String ?? ""
        self.amount = dictionary["amount"] as?
        String ?? ""
        self.currency = dictionary["currency"] as?
        String ?? ""
        self.tax_type = dictionary["tax_type"] as?
        String ?? ""
        self.tax_amount = dictionary["tax_amount"] as?
        String ?? ""
        self.tax_type = dictionary["tax_type"] as?
        String ?? ""
        self.tax_percentage = dictionary["tax_percentage"] as?
        String ?? ""
        self.total_amount = dictionary["total_amount"] as?
        String ?? ""
        self.status = dictionary["status"] as?
        String ?? ""
        
    }
    
}


