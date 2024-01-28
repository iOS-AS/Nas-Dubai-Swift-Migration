//
//  PTAInsertApiModel.swift
//  BISAD
//
//  Created by Mobatia Mac on 21/07/23.
//

import Foundation

// MARK: - Welcome
struct PTAInsertApiModel: Codable {
    let status: Int
    let message: String
    let data: PTAResponseDataDict?
}

// MARK: - DataClass
struct PTAResponseDataDict: Codable {
    let bookingID: Int

    enum CodingKeys: String, CodingKey {
        case bookingID = "booking_id"
    }
}
