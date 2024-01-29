//
//  LoginModel.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 18/12/23.
//

import UIKit
import CoreData

class LoginModel {
    var calledTime: Int = 0
    func callLoginApi(email: String, password: String, completion: @escaping (_ success: Bool, _ message: String) -> ()) {

        if email == "" {
//            alertMessage.value = "Please enter Email."
            completion(false, "Please enter Email.")
            return
        }
        if password == "" {
//            alertMessage.value = "Please enter Password."
            completion(false, "Please enter Password.")
            return
        }


        if Validation.isValidEmail(email) {
            ApiServices().callLoginAPI(email: email, password: password) { completed in
                print(completed)
                if completed.responsecode == "200" {
                    DefaultsWrapper().setAccessToken(completed.responseArray?.token ?? "")
                    DefaultsWrapper().setLoginStatus(true)
                    completion(true, "")
                } else if completed.responsecode == "132" {
//                    alertMessage.value = "Invalid username or password"
                    completion(false, "Invalid username or password")
                } else if completed.responsecode == "111" {
//                    alertMessage.value = "No students available."
                    completion(false, "No students available.")
                }
            }
        } else {
//            alertMessage.value = "Please enter valid Email."
            completion(false, "Please enter valid Email.")
        }
    }

}





struct Login: Codable {
    var responsecode: String?
    var responseArray: ResponseArray?

    enum CodingKeys: String, CodingKey {
        case responsecode
        case responseArray
    }
}

// MARK: - ResponseArray
struct ResponseArray: Codable {
    var token: String?
   
}





struct Student: Codable {
    var responseArray: StudentArray?
    var status: Int?
}

// MARK: - ResponseArray
struct StudentArray: Codable {
    var studentList: [SList]?

    enum CodingKeys: String, CodingKey {
        case studentList = "student_list"
    }
}

// MARK: - StudentList
struct SList: Codable {
    var name, id, house: String?
    var photo, unique_id: String?
    var studentListClass, section: String?
    var confirmed = false
    enum CodingKeys: String, CodingKey {
        case name, id, house, photo
        case studentListClass = "class"
        case section
        case unique_id = "unique_id"
    }
}


