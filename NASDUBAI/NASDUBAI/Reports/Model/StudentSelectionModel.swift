//
//  StudentSelectionModel.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 18/01/24.
//

import Foundation
import CoreData
//import SwiftDate

struct StudentSelectionModel {
    func getStudentFromCoreData(completion: (([StudentList]) -> ())) {
        let fetchRequest: NSFetchRequest<StudentList> = StudentList.fetchRequest()
        do {
            let studentList = try K.context.fetch(fetchRequest)
            completion(studentList)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func getWeekday() -> Int {
//        let today = Date()
//        if today.weekday != 6 && today.weekday != 7 {
//            return today.weekday
//        } else {
//            return 0
//        }
        return 0
    }
}

