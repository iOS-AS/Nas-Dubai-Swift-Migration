//
//  StaffCanteenInfoResponse.swift
//  NAS
//
//  Created by Mobatia Technology on 02/09/20.
//  Copyright © 2020 AJITH. All rights reserved.
//

import UIKit
class StaffCanteenInfoResponse: NSObject {
    var responsecode:String = ""
    var response: StaffCanteenResponse = StaffCanteenResponse([:])
    var error: Bool = false
    init(_ dataDict: [String: Any]) {
        if let status = dataDict["responsecode"] as? Int {
            self.responsecode = "\(status)"
        }else if let status = dataDict["responsecode"] as? String {
            self.responsecode = "\(status)"
        }
        self.error = (dataDict["Error"] != nil) // AccessToken Expiry or Invalid Error = True
        if error == false {
            self.response = StaffCanteenResponse(dataDict["response"] as? [String : Any] ?? [:])
        }
    }
}
class StaffCanteenResponse: NSObject {
    var statuscode:String = ""
    var response:String = ""
    var data: StaffCantenData = StaffCantenData([:])
    init(_ dictionary: [String: Any]) {
        if let status = dictionary["statuscode"] as? Int {
            self.statuscode = "\(status)"
        }else if let status = dictionary["statuscode"] as? String {
            self.statuscode = "\(status)"
        }
        self.response = dictionary["response"] as? String ?? ""
        self.data = StaffCantenData(dictionary["data"] as? [String : Any] ?? [:])
    }
}
class StaffCantenData: NSObject {
    var id: String = ""
    var name: String = ""
    var email: String = ""
    var staff_photo: String = ""
    var pickupLocation: String = ""
    var isAlldataYes: Bool = true
    init(_ dataDict: [String: Any]) {
        self.id = dataDict["id"] as? String ?? ""
        self.name = dataDict["name"] as? String ?? ""
        self.email = dataDict["email"] as? String ?? ""
        self.staff_photo = dataDict["staff_photo"] as? String ?? ""
        self.pickupLocation = dataDict["pickup_location"] as? String ?? ""
        if email.count == 0 {
            isAlldataYes = false
        }
        if pickupLocation.count == 0 {
            isAlldataYes = false
        }
    }
}


