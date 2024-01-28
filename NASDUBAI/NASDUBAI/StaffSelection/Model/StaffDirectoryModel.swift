//
//  StaffDirectory.swift
//  BISAD
//
//  Created by MOB-IOS-05 on 28/12/22.
//

import Foundation



struct StaffDirectoryModel {
    
    
    func processData(data: StaffDirectory?) -> (StaffDirectory?, APIError?) {
        
        if data?.status == 101 || data?.status == 102 {
            alertMessage.value = K.someErrorOccured
            return (nil, .requestFailed)
        } else if data?.status == 116 {
            return (nil, .tokenExpired)
        } else {
            print("data is \(data)")
            return (data, nil)
        }
    }
    
}



struct StaffDirectory: Codable {
    
    var status: Int?
    var  responseArray: StaffListApi?
    
    
    
}


struct StaffListApi: Codable {
    var department_staff: [StaffListArray]?
}

struct StaffListArray: Codable {
    var id: Int
    var staff_department_id: Int
    var name, email, staff_photo: String?
    var role: String?
    var staff_bio: String?
    var department_name : String?
}
