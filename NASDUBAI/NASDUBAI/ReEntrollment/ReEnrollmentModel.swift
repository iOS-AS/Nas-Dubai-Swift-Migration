//
//  ReEnrollmentModel.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 22/01/24.
//

import Foundation
struct  ReEnrollmentModel {
    
    fileprivate func sumitReEnrollment( _ dataValue: String , _ completion: @escaping (String, Bool) -> ()) {
       
        ApiServices().sumitReEnrollment(dataValue: dataValue) { (data) in
            if data.status == 105 {
                completion("Please pick a different date.", false)
            }
            if data.status == 100 {
                
                completion("Succesfully submitted your request.", true)
            }
        }
    }

    func sumitReEnrollment(dataValue: String, completion: @escaping (String, Bool) -> ()) -> String {

        sumitReEnrollment( dataValue, completion)
        
        return ""
    }
    
    
    func processData(data: ReEnrollment?) -> (ReEnrollment?, APIError?) {
        
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
    

struct ReEnrollment : Decodable {
    var status: Int?
    var responseArray: ReEnrollmentArray?
}

// MARK: - ResponseArray
struct ReEnrollmentArray: Decodable {
    
    var request: [ReEnrollmentStudent]?
       var user : ReEnrollmentUser?
       var settings : ReEnrollmentSettings?
    
       enum CodingKeys: String, CodingKey {
           case request = "students"
           case user = "user"
           case settings = "settings"
       }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.contains(.request) {
            self.request = try container.decodeIfPresent([ReEnrollmentStudent].self, forKey: .request)
        }
        if container.contains(.user){
            self.user = try container.decodeIfPresent(ReEnrollmentUser.self, forKey: .user)
        }
        if container.contains(.settings) {
            self.settings = try container.decodeIfPresent(ReEnrollmentSettings.self, forKey: .settings)
        }
    }
}

// MARK: - User
struct ReEnrollmentUser: Codable {
    var firstname: String?
    var last_name: String?
    var email: String?

    enum Codingkeys: String, CodingKey {
        case first_name = "firstname"
        case last_name = "last_name"
        case email = "email"
    }
}

struct ReEnrollmentSettings: Codable {
    var heading: String?
    var description: String?
    var t_and_c: String?
    var statement_url: String?
    var options: [String]?
    var question: String?

    enum Codingkeys: String, CodingKey {
        case heading = "heading"
        case description = "description"
        //case t_and_c = "t_and_c"
    }
}


struct ReEnrollmentStudent: Codable {
    
    var id: String?
    var unique_id: String?
    var name: String?
    var class_name : String?
    var section: String?
    var house: String?
    var photo: String?

    enum Codingkeys: String, CodingKey {
        
        case id = "id"
        case unique_id = "unique_id"
        case namee = "name"
        case class_name = "class_name"
        case section = "section"
        case house = "house"
        case photo = "photo"

    }
    
}




struct ReEnrollmentResponse {
    var studentId: String?
    var option: String?
}
