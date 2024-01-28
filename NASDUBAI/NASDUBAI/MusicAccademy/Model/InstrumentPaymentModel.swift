//
//  InstrumentPaymentModel.swift
//  NAS
//
//  Created by MOB-IOS-05 on 12/08/23.
//  Copyright © 2023 AJITH. All rights reserved.
//

import UIKit
// MARK: - InstrumentPaymentModel
struct InstrumentPaymentModel {
    var responsecode:String = ""
    var response: InstrumentPaymentResponseModel = InstrumentPaymentResponseModel([:])
    var error: Bool = false
    init(_ dataDict: [String: Any]) {
        if let status = dataDict["responsecode"] as? Int {
            self.responsecode = "\(status)"
        }else if let status = dataDict["responsecode"] as? String {
            self.responsecode = "\(status)"
        }
        self.error = (dataDict["Error"] != nil)
        if error == false{
            self.response = InstrumentPaymentResponseModel(dataDict["response"] as? [String : Any] ?? [:])
        }
    }
}
// MARK: - InstrumentPaymentResponseModel
struct InstrumentPaymentResponseModel {
    var statuscode:String = ""
    var response:String = ""
    var data: InstrumentPaymentResponseDataModel = InstrumentPaymentResponseDataModel([:])
    init(_ dictionary: [String: Any]) {
       
        if let status = dictionary["statuscode"] as? Int {
            self.statuscode = "\(status)"
        }else if let status = dictionary["statuscode"] as? String {
            self.statuscode = "\(status)"
        }
        self.response = dictionary["response"] as? String ?? ""
        self.data = InstrumentPaymentResponseDataModel(dictionary["data"] as? [String:Any] ?? [:])
    }
}

struct InstrumentPaymentResponseDataModel {
    var paymentHistory: [InstrumentPaymentHistoryModel] = []
    init(_ dict:[String:Any]) {
        let dataList = dict["payment_history"] as? [[String:Any]] ?? []
        self.paymentHistory = []
        for i in 0..<dataList.count{
            self.paymentHistory.append(InstrumentPaymentHistoryModel(dataList[i]))
        }
    }
}

// MARK: - InstrumentPaymentResponseDataModel
struct InstrumentPaymentHistoryModel {
    var order_reference:String = ""
    var created_on:String = ""
    var order_total:String = ""
    var student_name:String = ""
    var parent_name:String = ""
    var invoice_note:String = ""
    var payment_type:String = ""
    var trn_no:String = ""
    
    var orderSummery: [InstrumentPaymentOrderSummeryModel] = []
    init(_ dictionary: [String: Any]) {
        
        self.order_reference = dictionary["order_reference"] as? String ?? ""
        self.created_on = dictionary["created_on"] as? String ?? ""
        self.order_total = dictionary["order_total"] as? String ?? ""
        self.student_name = dictionary["student_name"] as? String ?? ""
        self.parent_name = dictionary["parent_name"] as? String ?? ""
        self.invoice_note = dictionary["invoice_note"] as? String ?? ""
        self.payment_type = dictionary["payment_type"] as? String ?? ""
        self.trn_no = dictionary["trn_no"] as? String ?? ""
        
        let dataList = dictionary["order_summery"] as? [[String:Any]] ?? []
        self.orderSummery = []
        for i in 0..<dataList.count{
            self.orderSummery.append(InstrumentPaymentOrderSummeryModel(dataList[i]))
        }
    }
}

// MARK: - InstrumentPaymentOrderSummeryModel
struct InstrumentPaymentOrderSummeryModel {
    var id:Int
    var actual_amount:String = ""
    var tax_amount:String = ""
    var total_amount:String = ""
    var instrument_name:String = ""
    var term_name:String = ""
    var lesson_name:String = ""
    
    init(_ dictionary: [String: Any]) {
        self.id = dictionary["id"] as?
        Int ?? 0
        self.actual_amount = dictionary["actual_amount"] as?
        String ?? ""
        self.tax_amount = dictionary["tax_amount"] as?
        String ?? ""
        self.total_amount = dictionary["total_amount"] as?
        String ?? ""
        self.instrument_name = dictionary["instrument_name"] as?
        String ?? ""
        self.term_name = dictionary["term_name"] as?
        String ?? ""
        self.lesson_name = dictionary["lesson_name"] as?
        String ?? ""
    }
    
}
