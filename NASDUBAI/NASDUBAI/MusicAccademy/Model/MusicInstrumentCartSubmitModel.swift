//
//  MusicInstrumentCartSubmitModel.swift
//  NAS
//
//  Created by Mobatia Mac on 15/08/23.
//  Copyright © 2023 AJITH. All rights reserved.
//

import Foundation

struct MusicInstrumentCartSubmitModel: Codable {
    let responsecode: String?
    var response: CartResponseModel

    init(_ dataDict: [String: Any]) {
        if let status = dataDict["responsecode"] as? Int {
            self.responsecode = "\(status)"
        } else if let status = dataDict["responsecode"] as? String {
            self.responsecode = "\(status)"
        } else {
            self.responsecode = nil
        }
        
        self.response = CartResponseModel(dataDict["response"] as? [String: Any] ?? [:])
    }
}

struct CartResponseModel: Codable {
    let statuscode: String?
    let response: String?

    init(_ dataDict: [String: Any]) {
        if let status = dataDict["statuscode"] as? Int {
            self.statuscode = "\(status)"
        } else if let status = dataDict["statuscode"] as? String {
            self.statuscode = "\(status)"
        } else {
            self.statuscode = nil
        }
        self.response = dataDict["response"] as? String ?? ""
    }
}

