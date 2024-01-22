//
//  ReportsModel.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 18/01/24.
//

import Foundation

struct ReportsModel {
    func getData(studentID: String, completion: @escaping ([ProgressReportArray]?) -> Void) {
        ApiServices().getProgressReport(studentID: studentID) { (data) in
            if let a = data.responseArray {
                completion(a)
            } else {
                completion(nil)
            }
        }
    }

    func processData(data: ProgressReport?) -> (ProgressReport?, APIError?) {
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


struct ProgressReport: Codable {
    var status: Int?
    var responseArray: [ProgressReportArray]?
}

// MARK: - ResponseArray
struct ProgressReportArray: Codable {
    var acyear: String?
    var data: [ProgressReportData]?

    enum CodingKeys: String, CodingKey {
        case acyear = "Acyear"
        case data
    }
}

// MARK: - Datum
struct ProgressReportData: Codable {
    var id: String?
    var reportCycle, updatedAt: String?
    var file: String?
    var viewreport: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case reportCycle = "report_cycle"
        case updatedAt = "updated_at"
        case file, viewreport
    }
}
