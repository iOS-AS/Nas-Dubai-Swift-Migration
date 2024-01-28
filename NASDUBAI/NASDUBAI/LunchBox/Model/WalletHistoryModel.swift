//
//  WalletHistoryModel.swift
//  NAS
//
//  Created by Naveeth's on 18/10/21.
//

import Foundation
//
//  WalletHistoryModel.swift
//  BISAD
//
//  Created by Joel Leo on 17/02/23.
//

import Foundation
struct WalletHistoryModel {
    
    func processData(data: WalletHistoryData?) -> (WalletHistoryData?, APIError?) {
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



// MARK: - WalletHistoryData
struct WalletHistoryData: Codable {
    var status: Int?
    var responseArray: WalletHistoryResponseArrayData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case responseArray = "responseArray"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        if container.contains(.responseArray) {
            self.responseArray = try container.decodeIfPresent(WalletHistoryResponseArrayData.self, forKey: .responseArray)
        }
    }
}

// MARK: - WalletHistoryResponseArrayData
struct WalletHistoryResponseArrayData: Codable {
    var credit_history: [WalletHistoryCreditHistoryData]?

    enum CodingKeys: String, CodingKey {
        case credit_history = "credit_history"
    }
}

// MARK: - WalletHistoryCreditHistoryData
struct WalletHistoryCreditHistoryData : Codable {

    var parent_name : String?
    var email : String?
    var id : Int?
    var student_id : Int?
    var user_id : Int?
    var amount : String?
    var bill_no : Int?
    var keycode : String?
    var status : Int?
    var created_on : String?
    var invoice_note : String?
    var trn_no : String?
    var payment_type : String?
    var formattedDate: String?
    var order_reference: String?
    
    enum CodingKeys: String, CodingKey {
        case parent_name
        case email
        case id
        case student_id
        case user_id
        case amount
        case bill_no
        case keycode
        case status
        case created_on
        case invoice_note
        case trn_no
        case payment_type
        case formattedDate
        case order_reference
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.parent_name = try container.decodeIfPresent(String.self, forKey: .parent_name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.student_id = try container.decodeIfPresent(Int.self, forKey: .student_id)
        self.user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
        self.amount = try container.decodeIfPresent(String.self, forKey: .amount)
        self.bill_no = try container.decodeIfPresent(Int.self, forKey: .bill_no)
        self.keycode = try container.decodeIfPresent(String.self, forKey: .keycode)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        self.created_on = try container.decodeIfPresent(String.self, forKey: .created_on)
        self.invoice_note = try container.decodeIfPresent(String.self, forKey: .invoice_note)
        self.trn_no = try container.decodeIfPresent(String.self, forKey: .trn_no)
        self.payment_type = try container.decodeIfPresent(String.self, forKey: .payment_type)
        self.formattedDate = try container.decodeIfPresent(String.self, forKey: .formattedDate)
        self.order_reference = try container.decodeIfPresent(String.self, forKey: .order_reference)
    }

}
