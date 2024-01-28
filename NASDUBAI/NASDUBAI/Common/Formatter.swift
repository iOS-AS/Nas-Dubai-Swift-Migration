//
//  Formatter.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 22/01/24.
//

import Foundation
@objc class NASDateFormatter:NSObject {

    static var cache = NSCache<NSString, DateFormatter>()

    @objc class func defaultDateFormatter() -> DateFormatter {

        let mmtCalendar = Calendar.defaultNAS()
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = mmtCalendar
//        dateFormatter.locale = Locale.usLocale()
        //dateFormatter.locale = Locale(identifier: AppLanguage.shared.language.rawValue)
        dateFormatter.formatterBehavior = DateFormatter.Behavior.behavior10_4
//        dateFormatter.timeZone = .current
        return dateFormatter
    }
}
public extension Calendar {

//    static func defaultNAS() -> Calendar {
//        return Calendar(identifier: .gregorian)
//    }

    static func defaultNAS() -> Calendar {
        var utcCalendar: Calendar =  Calendar(identifier: .gregorian)
        utcCalendar.timeZone = .current
            //TimeZone.utcTimezone()
        utcCalendar.locale = Locale.usLocale()
        return utcCalendar
    }
}
public extension Locale {

    static func usLocale() -> Locale {
        return Locale(identifier: "en_US_POSIX")
    }

    static func indianLocale() -> Locale {
        return Locale(identifier: "en_IN")
    }
}
extension String {
    
    func getFormattedDate(currentFomat:String, expectedFromat: String) -> String? {

        let dateFormatterGet = NASDateFormatter.defaultDateFormatter()
        dateFormatterGet.dateFormat = currentFomat

        if let date = dateFormatterGet.date(from: self) { //?? Date()
            dateFormatterGet.dateFormat = expectedFromat
            return dateFormatterGet.string(from: date)
        }
        return nil
    }
    
    func getFormattedDateForUS(currentFomat:String, expectedFromat: String) -> String? {
        let dateFormatterGet = NASDateFormatter.defaultDateFormatter()
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterGet.dateFormat = currentFomat

        if let date = dateFormatterGet.date(from: self) { //?? Date()
            dateFormatterGet.dateFormat = expectedFromat
            return dateFormatterGet.string(from: date)
        }
        return nil
    }
}
struct DateFormatterType {

    static let yyyy_MM_dd_T_HH_mm_ssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    static let yyyy_MM_dd_HH_mm_ss = "yyyy-MM-dd HH:mm:ss"
    static let EEEE_dd_MMMM_yyyy = "EEEE dd MMMM yyyy"
    static let dd_MMM_yyyy_hh_mm_a = "dd-MMM-yyyy hh:mm a"

    static let dd_MMM_yyyy = "dd MMM yyyy"
    static let dd_MMM_yyyy_Hyphen = "dd-MMM-yyyy"
    static let yyyy_MM_dd = "yyyy-MM-dd"
    static let dd_MM_yyyy = "dd-MM-yyyy"

    static let hh_mm_a = "hh:mm a"
    static let HH_mm_ss = "HH:mm:ss"
    static let HH_mm = "HH:mm"

    static let yyyy = "yyyy"
    static let mm = "MM"
    static let dd = "dd"
    static let dd_MM_yyyy_hh_mm_a = "dd-MM-yyyy hh:mm a"
}
extension Date {
    static func getCurrentDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: Date())
    }
    
    static func getCurrentDateDDMMYYYY() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            return dateFormatter.string(from: Date())
    }
    static func getTomorrowDateDDMMYYYY() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let dateValue = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
            return dateFormatter.string(from: dateValue)
    }
    
    func getCurrentDateWithTimeForPayment() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter.string(from: self)
    }
}

