//
//  MusicAcademyInstrumentsList.swift
//  NAS
//
//  Created by MOB-IOS-05 on 12/08/23.
//  Copyright © 2023 AJITH. All rights reserved.
//

import UIKit


struct InstrumentListResponseModel {
    var responsecode:String = ""
    var response: InstrumentResponse = InstrumentResponse([:])
    var error: Bool = false
    init(_ dataDict: [String: Any]) {
        if let status = dataDict["responsecode"] as? Int {
            self.responsecode = "\(status)"
        }else if let status = dataDict["responsecode"] as? String {
            self.responsecode = "\(status)"
        }
        self.error = (dataDict["Error"] != nil)
        if error == false{
            self.response = InstrumentResponse(dataDict["response"] as? [String : Any] ?? [:])
        }
    }
}
// MARK: - Response
struct InstrumentResponse {
    var statuscode: String = ""
    var response:String = ""
    var data: InstrumentResponseData = InstrumentResponseData([:])
    init(_ dictionary: [String: Any]) {
        self.statuscode = dictionary["statuscode"] as? String ?? ""
        self.response = dictionary["response"] as? String ?? ""
        self.data = InstrumentResponseData(dictionary["data"] as? [String:Any] ?? [:])
    }
}

struct InstrumentResponseData {
    var instrument_data: [InstrumentListData] = []
    
    init(_ dictionary: [String: Any]) {
        let dataList = dictionary["instrument_data"] as? [[String:Any]] ?? []
        for i in 0..<dataList.count{
            self.instrument_data.append(InstrumentListData(dataList[i]))
        }
    }
}

struct InstrumentListData {
    var instrument_id: String = ""
    var instrument_name: String = ""
    var instrument_selected: Bool = false
    var term_data: [TermData] = []
    private var lessonAlredyPurchasedCount: Int = 0
    private(set) var allLessonAlreadyPurcasedSucceded: Bool = false
    
    init(_ dataDict: [String:Any]) {
        self.instrument_id = dataDict["instrument_id"] as? String ?? ""
        self.instrument_name = dataDict["instrument_name"] as? String ?? ""
        self.instrument_selected = dataDict["instrument_selected"] as? Bool ?? (0 != 0)
        let termDataArray = dataDict["term_data"] as? [[String: Any]] ?? []
        self.lessonAlredyPurchasedCount = 0
        self.allLessonAlreadyPurcasedSucceded = false
        for i in 0..<termDataArray.count {
            let termObj = TermData(termDataArray[i])
            if termObj.isLessonAlredyOrdered {
                self.lessonAlredyPurchasedCount += 1
            }
            self.term_data.append(termObj)
        }
        if self.term_data.count == self.lessonAlredyPurchasedCount {
            self.allLessonAlreadyPurcasedSucceded = true
        }
    }
}
struct TermData {
    var term_id:String = ""
    var term_name:String = ""
    var remaining_slot_count:Int = 0
    var lesson_data: [LessonData] = []
    var allowSelectionRelatedToUI: Bool = true
    var isLessonAlredyOrdered: Bool = false
    
    init(_ dataDict: [String: Any]) {
        self.term_id = dataDict["term_id"] as? String ?? ""
        self.term_name = dataDict["term_name"] as? String ?? ""
        self.remaining_slot_count = dataDict["remaining_slot_count"] as? Int ?? 0
        let lessonDataArray = dataDict["lesson_data"] as? [[String:Any]] ?? []
        for i in 0..<lessonDataArray.count {
            let lessonObj = LessonData(lessonDataArray[i])
            if lessonObj.order_success {
                if allowSelectionRelatedToUI {
                    allowSelectionRelatedToUI = false
                }
                self.isLessonAlredyOrdered = true
            }
            self.lesson_data.append(lessonObj)
        }
        if self.allowSelectionRelatedToUI && self.remaining_slot_count == 0 {
            self.allowSelectionRelatedToUI = false
        }
    }
}

struct LessonData {
    var id: Int = 0
    var name: String = ""
    var currency:String = ""
    var currency_symbol:String = ""
    var total_amount:String = ""
    var course_selected:Bool = false
    var order_success:Bool = false
    
    init(_ dictionary: [String: Any]) {
        self.id = dictionary["id"] as? Int ?? 0
        self.name = dictionary["name"] as? String ?? ""
        self.currency = dictionary["currency"] as? String ?? ""
        self.currency_symbol = dictionary["currency_symbol"] as? String ?? ""
        self.total_amount = dictionary["total_amount"] as? String ?? ""
        self.course_selected = dictionary["course_selected"] as? Bool ?? (0 != 0)
        self.order_success = dictionary["order_success"] as? Bool ?? (0 != 0)
        
    }
}

/// MARK: - MusicInstrumentsListModel
//struct MusicAcademyInstrumentsListModel: Codable {
//    let responsecode: String?
//    let response: ResponseDict?
//}
//
//// MARK: - Response
//struct ResponseDict: Codable {
//    let statuscode: Int?
//    let response: String?
//    let data: DataClassDict?
//}
//
//// MARK: - DataClass
//struct DataClassDict: Codable {
//    let instrumentData: [InstrumentDetailsArray]
//
//    enum CodingKeys: String, CodingKey {
//        case instrumentData = "instrument_data"
//    }
//}
//
//// MARK: - InstrumentDetailsArray
//struct InstrumentDetailsArray: Codable {
//    let instrumentID, instrumentName: String
//    let instrumentSelected: Int
//    let termData: [TermDataArray]
//
//    enum CodingKeys: String, CodingKey {
//        case instrumentID = "instrument_id"
//        case instrumentName = "instrument_name"
//        case instrumentSelected = "instrument_selected"
//        case termData = "term_data"
//    }
//}
//
//// MARK: - TermDatum
//struct TermDataArray: Codable {
//    let termID, termName, remainingSlotCount: String?
//    let lessonData: [LessonDatum]
//
//    enum CodingKeys: String, CodingKey {
//        case termID = "term_id"
//        case termName = "term_name"
//        case remainingSlotCount = "remaining_slot_count"
//        case lessonData = "lesson_data"
//    }
//}
//
//// MARK: - LessonDatum
//struct LessonDatum: Codable {
//    let id: Int?
//    let name, currency, currencySymbol, totalAmount: String?
//    let courseSelected: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, currency
//        case currencySymbol = "currency_symbol"
//        case totalAmount = "total_amount"
//        case courseSelected = "course_selected"
//    }
//}
