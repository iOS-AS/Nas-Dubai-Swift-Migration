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
                    DefaultsWrapper().setAccessToken(completed.response?.responseArray?.token ?? "")
                    DefaultsWrapper().setLoginStatus(true)
                    completion(true, "")
                } else if completed.response?.statuscode == "305" {
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
    
    func deleteRecords() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentList")
        let result = try? K.context.fetch(fetchRequest)
            let resultData = result as! [StudentList]
            for object in resultData {
                K.context.delete(object)
            }
            do {
                try K.context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {

            }
    }

    func getStudentList(completion: @escaping () -> ()) {
        calledTime = calledTime + 1
        print("Called\(calledTime)")
        ApiServices().getStudentList { (completed) in
            if completed.responsecode == "200" {
                if let studentArray = completed.response?.data {
                    self.deleteRecords()
                    for i in studentArray {
                        let newStudent = StudentList(context: K.context)
                        newStudent.house = i.house
                        newStudent.id = i.id
                        newStudent.name = i.name
                        newStudent.photo = i.photo
                        newStudent.sclass = i.studentListClass
                        newStudent.section = i.section
                        newStudent.wallet = i.wallet
                        newStudent.confirmed = false
                        do {
                            try K.context.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    completion()
                }
            }
        }
    }

}


struct Login: Codable{
    var responsecode: String?
    var response: LoginReponse?
    enum CodingKeys: String, CodingKey {
        case responsecode
        case response
    }
}


struct LoginReponse: Codable {
    var response: String?
    var statuscode: String?
    var responseArray: ResponseArray?

    enum CodingKeys: String, CodingKey {
        case response
        case responseArray
        case statuscode
    }
}

// MARK: - ResponseArray
struct ResponseArray: Codable {
    var token: String?
   
}





struct Student: Codable {
    var responsecode: String?
    var response: StudentReponse?
    enum CodingKeys: String, CodingKey {
        case responsecode
        case response
    }
}
struct StudentReponse: Codable {
    var response: String?
    var statuscode: String?
    var data: [SList]?

    enum CodingKeys: String, CodingKey {
        case response
        case statuscode
        case data
    }
}


// MARK: - StudentList
struct SList: Codable {
    var name, id, house: String?
    var photo, wallet: String?
    var studentListClass, section: String?
    var confirmed = false
    enum CodingKeys: String, CodingKey {
        case name, id, house, photo
        case studentListClass = "class"
        case section
        case wallet = "wallet"
    }
}


