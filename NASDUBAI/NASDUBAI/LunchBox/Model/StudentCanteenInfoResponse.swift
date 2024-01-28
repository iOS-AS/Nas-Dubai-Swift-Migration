//
//  StudentCanteenInfoResponse.swift
//  NAS
//
//  Created by Mobatia Technology on 26/08/20.
//  Copyright © 2020 AJITH. All rights reserved.
//

import UIKit
class StudentCanteenInfoResponse: NSObject {
    var responsecode:String = ""
    var response: StudentCanteenResponse = StudentCanteenResponse([:])
    var error: Bool = false
    init(_ dataDict: [String: Any]) {
        if let status = dataDict["responsecode"] as? Int {
            self.responsecode = "\(status)"
        }else if let status = dataDict["responsecode"] as? String {
            self.responsecode = "\(status)"
        }
        self.error = (dataDict["Error"] != nil) // AccessToken Expiry or Invalid Error = True
        if error == false {
            self.response = StudentCanteenResponse(dataDict["response"] as? [String : Any] ?? [:])
        }
    }
}
class StudentCanteenResponse: NSObject {
    var statuscode:String = ""
    var response:String = ""
    var data: StudentCantenData = StudentCantenData([:])
    init(_ dictionary: [String: Any]) {
        if let status = dictionary["statuscode"] as? Int {
            self.statuscode = "\(status)"
        }else if let status = dictionary["statuscode"] as? String {
            self.statuscode = "\(status)"
        }
        self.response = dictionary["response"] as? String ?? ""
        self.data = StudentCantenData(dictionary["data"] as? [String : Any] ?? [:])
    }
}
class StudentCantenData: NSObject {
    var id: String = ""
    var name: String = ""
    var email: String = ""
    var classroomNumber: String = ""
    var pickupLocation: String = ""
    var isAlldataYes: Bool = true
    init(_ dataDict: [String: Any]) {
        self.id = dataDict["id"] as? String ?? ""
        self.name = dataDict["name"] as? String ?? ""
        self.email = dataDict["email"] as? String ?? ""
        self.classroomNumber = dataDict["classroom_number"] as? String ?? ""
        self.pickupLocation = dataDict["pickup_location"] as? String ?? ""
        if classroomNumber.count == 0 {
            isAlldataYes = false
        }
        if email.count == 0 {
            isAlldataYes = false
        }
        if pickupLocation.count == 0 {
            isAlldataYes = false
        }
    }
}

