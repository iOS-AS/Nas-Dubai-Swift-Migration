//
//  DefaultsWrapper.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 18/12/23.
//

import UIKit




struct DefaultsWrapper {

    let defaults = UserDefaults.standard

    func clearData() {
        defaults.set(false, forKey: "LOGINSTATUS")
        defaults.set("", forKey: "UserID")
        defaults.set("", forKey: "UserCode")
        defaults.set("", forKey: "AccessToken")
        defaults.set("", forKey: "UserEmailID")
    }


    func setLoginStatus(_ status: Bool) {
        defaults.set(status, forKey: "LOGINSTATUS")
    }

    func getLoginStatus() -> Bool {
        print(defaults.bool(forKey: "LOGINSTATUS"))
        return defaults.bool(forKey: "LOGINSTATUS")
    }


    func setAccessToken(_ token: String) {
        defaults.set(token, forKey: "token")
    }

    func getAccessToken() -> String {
        return defaults.string(forKey: "token") ?? ""
    }

    func setUserID(_ UserID: String) {
        defaults.set(UserID, forKey: "UserID")
    }

    func getUserID() -> String {
        return defaults.string(forKey: "UserID") ?? ""
    }

    func setUserCode(_ UserCode: String) {
        defaults.set(UserCode, forKey: "UserCode")
    }

    func getUserCode() -> String {
        return defaults.string(forKey: "UserCode") ?? ""
    }

    func setUserEmailID(_ email: String) {
        defaults.set(email, forKey: "UserEmailID")
    }

    func getUserEmailID() -> String {
        return defaults.string(forKey: "UserEmailID") ?? ""
    }

    func setFCM(_ token: String) {
        defaults.set(token, forKey: "FCMID")
    }

    func getFCM() -> String {
        return defaults.string(forKey: "FCMID") ?? ""
    }


    func dataCollectionEnabled(_ enable: Bool) {
        print(enable)
        defaults.set(enable, forKey: "DATACOLLECTIONSTATUS")
    }

    func isDataCollectionEnabled() -> Bool {
        return defaults.bool(forKey: "DATACOLLECTIONSTATUS")
    }

    func setTriggerType(_ type: Int) {
        defaults.set(type, forKey: "CurrentTriggerType")
    }

    func getTriggerType() -> Int {
        return defaults.integer(forKey: "CurrentTriggerType")
    }
    
    
    func setFlagValue(_ flag: Bool) {
        defaults.set(flag, forKey: "flag")
    }
    
    func getFlagValue()-> Bool {
        return defaults.bool(forKey: "flag")
    }
    
    
    func setPTAFlagValue(_ flag: Bool) {
        defaults.set(flag, forKey: "flag")
    }
    
    func getPTAFlagValue()-> Bool {
        return defaults.bool(forKey: "flag")
    }
    
    func setStatusType(_ type: Int) {
        defaults.set(type, forKey: "statusRe")
    }

    func getStatusType() -> Int {
        return defaults.integer(forKey: "statusRe")
    }
    
    
    func setStatusTypePTA(_ type: String) {
        defaults.set(type, forKey: "statusPTA")
    }

    func getStatusTypePTA() -> String {
        return defaults.string(forKey: "statusPTA") ?? ""
    }

    func setDateArray(_ imageArray: NSArray) {
        defaults.set(imageArray, forKey: "SELECTED_DATE_ARRAY")
    }

    func getDateArray() -> NSArray {
        return (defaults.value(forKey: "SELECTED_DATE_ARRAY") as? NSArray) ?? NSArray()
    }
    
    func getNoticeImage()-> Bool {
        return defaults.bool(forKey: "noticeImage")
    }
    
}






//known method

class DefaultWrapper {

static let shared = DefaultWrapper()
let Defaults = UserDefaults.standard
    
    var surveyId: Int{
        set {
            Defaults.set(newValue, forKey: DefaultConstants.surveyId)
        }
        get{
            Defaults.integer(forKey: DefaultConstants.surveyId)
        }
    }
}

class DefaultConstants {
    
    static var surveyId  =  "surveyId"
    
}

