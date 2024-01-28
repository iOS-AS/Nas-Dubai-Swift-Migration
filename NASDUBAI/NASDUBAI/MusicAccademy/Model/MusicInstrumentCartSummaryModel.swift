//
//  MusicInstrumentCartSummaryModel.swift
//  NAS
//
//  Created by Mobatia Mac on 15/08/23.
//  Copyright © 2023 AJITH. All rights reserved.
//

import Foundation

// MARK: - MusicInstrumentCartSummaryModel
class MusicInstrumentCartSummaryResponseModel: NSObject {
    var responsecode:String = ""
    var response: MusicInstrumentCartSummaryOrderResponse = MusicInstrumentCartSummaryOrderResponse([:])
    var error: Bool = false
    init(_ dataDict: [String: Any]) {
        if let status = dataDict["responsecode"] as? Int {
            self.responsecode = "\(status)"
        }else if let status = dataDict["responsecode"] as? String {
            self.responsecode = "\(status)"
        }
        self.error = (dataDict["Error"] != nil)
        if error == false{
            self.response = MusicInstrumentCartSummaryOrderResponse(dataDict["response"] as? [String : Any] ?? [:])
        }
    }
}
// MARK: - Response
class MusicInstrumentCartSummaryOrderResponse: NSObject {
    var statuscode:String = ""
    var response:String = ""
    var data: MusicInstrumentCartSummaryOrderData = MusicInstrumentCartSummaryOrderData([:])
    init(_ dictionary: [String: Any]) {
       
        if let status = dictionary["statuscode"] as? Int {
            self.statuscode = "\(status)"
        }else if let status = dictionary["statuscode"] as? String {
            self.statuscode = "\(status)"
        }
        self.response = dictionary["response"] as? String ?? ""
        self.data = MusicInstrumentCartSummaryOrderData(dictionary["data"] as? [String:Any] ?? [:])
    }
}
class MusicInstrumentCartSummaryOrderData: NSObject{
    var instrument_data: [MusicInstrumentCartSummaryOrderListData] = []
    init(_ dict:[String:Any]) {
        let dataList = dict["instrument_data"] as? [[String:Any]] ?? []
        for i in 0..<dataList.count{
            self.instrument_data.append(MusicInstrumentCartSummaryOrderListData(dataList[i]))
        }
    }
}
class MusicInstrumentCartSummaryOrderListData: NSObject {
    var id:Int
    var intrument_name:String = ""
    var order_data: [MusicInstrumentCartSummaryCartData] = []
    init(_ dictionary: [String: Any]) {
        
        self.id = dictionary["instrument_id"] as? Int ?? 0
        self.intrument_name = dictionary["instrument_name"] as? String ?? ""
        let dataList = dictionary["cart_data"] as? [[String:Any]] ?? []
        self.order_data = []
        for i in 0..<dataList.count{
            self.order_data.append(MusicInstrumentCartSummaryCartData(dataList[i]))
        }
       
        
    }
}
class MusicInstrumentCartSummaryCartData: NSObject{
    var order_id:Int
    var order_reference:String = ""
    var student_id:Int = 0
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
        self.order_id = dictionary["cart_id"] as?
        Int ?? -1
        self.order_reference = dictionary["order_reference"] as?
        String ?? ""
        self.student_id = dictionary["student_id"] as?
        Int ?? 0
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


