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


//        if Validation.isValidEmail(email) {
//            ApiServices().callLoginAPI(email: email, password: password) { completed in
//                print(completed)
//                if completed.status == 100 {
//                    DefaultsWrapper().setUserCode(completed.userCode ?? "")
//                    DefaultsWrapper().setAccessToken(completed.token ?? "")
//                    DefaultsWrapper().setUserID(completed.responseArray?.userid ?? "")
//                    DefaultsWrapper().setLoginStatus(true)
//                    completion(true, "")
//                } else if completed.status == 132 {
////                    alertMessage.value = "Invalid username or password"
//                    completion(false, "Invalid username or password")
//                } else if completed.status == 111 {
////                    alertMessage.value = "No students available."
//                    completion(false, "No students available.")
//                }
//            }
//        }
        else {
//            alertMessage.value = "Please enter valid Email."
            completion(false, "Please enter valid Email.")
        }
    }

//    func deleteRecords() {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentList")
//        let result = try? K.context.fetch(fetchRequest)
//            let resultData = result as! [StudentList]
//            for object in resultData {
//                K.context.delete(object)
//            }
//            do {
//                try K.context.save()
//                print("saved!")
//            } catch let error as NSError  {
//                print("Could not save \(error), \(error.userInfo)")
//            } catch {
//
//            }
//    }

    func getStudentList(completion: @escaping () -> ()) {
        calledTime = calledTime + 1
        print("Called\(calledTime)")
//        ApiServices().getStudentList { (completed) in
//            if completed.status == 100 {
//                if let studentArray = completed.responseArray?.studentList {
//                    self.deleteRecords()
////                    for i in studentArray {
////                        let newStudent = StudentList(context: K.context)
////                        newStudent.house = i.house
////                        newStudent.id = i.id
////                        newStudent.name = i.name
////                        newStudent.photo = i.photo
////                        newStudent.sclass = i.studentListClass
////                        newStudent.section = i.section
////                        newStudent.unique_id = i.unique_id
////                        newStudent.confirmed = false
////                        do {
////                            try K.context.save()
////                        } catch {
////                            print(error.localizedDescription)
////                        }
////                    }
//                    completion()
//                }
//            }
//        }
    }
}





struct Login: Codable {
    var status: Int?
    var userCode: String?
    var responseArray: ResponseArray?
    var token: String?

    enum CodingKeys: String, CodingKey {
        case status
        case userCode = "user_code"
        case responseArray, token
    }
}

// MARK: - ResponseArray
struct ResponseArray: Codable {
    var userid: String?
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

