//
//  K.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 19/12/23.
//

import UIKit

struct K {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    static let tileArray = ["Notifications",
                       "Early Years",
                       "Primary",
                       "Calendar",
                       "Secondary",
                       "Gallery",
                       "Payments",
                       "Lunch Box",
                       "About Us"]
     


    //MARK:- Alert Messages

    static let regUserAlertMessage = "This feature is only available for registered users."
    static let fillOwnFields = "Please confirm all mandatory fields in own details."
    static let fillContactFields = "Please confirm all mandatory fields in family contact details."
    static let fillPassportFields = "Please confirm all mandatory fields in passport details."
    static let fillHealthFields = "Please confirm all mandatory fields in Health details."
    static let dataCollectionSuccess = "Thank you for updating your details, please wait 5 working days for the changes to take effect."
    static let atleastOneMinContact = "Contact cannot be deleted, there must be at least one Contact associated with your family."
    static let deleteContact = "Are you sure you want to delete this Contact?"
    static let emailExists = "Email id already exists with another contact"
    static let updateNextTime = "Please update this information next time."
    static let confirmAll = "Please confirm all details to continue."
    static let dataCollectionTriggerSuccess = "Data collection triggered successfully."

    static let noDataFound          = "No data found"
    static let noStaffFound         = "No staff details available for the student"
    static let noStudentInfo        = "Student Information is not available"
    static let noNewsLetters        = "Communications is not available"
    static let noSocialMedia        = "Social media links are not available"
    static let noReports            = "No reports available"
    static let noCurriculum         = "Curriculum details is not available"
    static let noApps               = "No app is available"
    static let noCalendarDetails    = "No calendar details available"
    static let someErrorOccured     = "Some error occurred"
    static let noNewMessages        = "No new messages"
    static let noHistoryAvailable   = "No history available"
    static let noRecordFound        = "No records found"
    static let checkBox     = "Please Check the above terms and condition for continue the submission."

    struct EntityNames {
        static let KinDetails = "KinDetails"
        static let OwnDetails = "OwnDetails"
        static let StudentList = "StudentList"
        static let PassportDetails = "PassportDetails"
        static let HealthAndInsurances = "HealthAndInsurances"
    }
}


