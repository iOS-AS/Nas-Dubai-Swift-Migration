//
//  File.swift
//  NAS
//
//  Created by Mobatia Technology on 10/09/20.
//  Copyright © 2020 AJITH. All rights reserved.
//

import Foundation
class SelectedDates: NSObject {
    var Date:String = ""
    var EEE:String = ""
    var MMM:String = ""
    var DD:String = ""
    var YYYY:String = ""
    var isClicked: String = "0"
     init(_ date: String) {
        self.Date = date
        self.EEE = getDayNameBy(stringDate: date)
        self.MMM = getDateMonth(stringDate: date)
        self.DD = getDayDigitBy(stringDate: date)
        self.YYYY = getDateYearFormat_YYYY(stringDate: date)
    }
}
func getDayNameBy(stringDate: String) -> String
{
    let df  = DateFormatter()
    df.dateFormat = "YYYY-MM-dd"
    let date = df.date(from: stringDate)!
    df.dateFormat = "EEE"
    return df.string(from: date);
}
func getDayIndication_EEEE(stringDate: String) -> String
{
    let df  = DateFormatter()
    df.dateFormat = "YYYY-MM-dd"
    let date = df.date(from: stringDate)!
    df.dateFormat = "EEEE"
    return df.string(from: date);
}
func getDayDigitBy(stringDate: String) -> String
{
    let df  = DateFormatter()
    df.dateFormat = "YYYY-MM-dd"
    let date = df.date(from: stringDate)!
    df.dateFormat = "dd"
    return df.string(from: date);
}
func getDateMonth(stringDate: String) -> String
{
    let df  = DateFormatter()
    df.dateFormat = "YYYY-MM-dd"
    let date = df.date(from: stringDate)!
    df.dateFormat = "MMM"
    return df.string(from: date);
}
func getDateFormatMMMMYYYY(stringDate: String) -> String
{
    let df  = DateFormatter()
    df.dateFormat = "YYYY-MM-dd"
    let date = df.date(from: stringDate)!
    df.dateFormat = "MMMM yyyy"
    return df.string(from: date);
}
func getDateYearFormat_YYYY(stringDate: String) -> String
{
    let df  = DateFormatter()
    df.dateFormat = "YYYY-MM-dd"
    let date = df.date(from: stringDate)!
    df.dateFormat = "yyyy"
    return df.string(from: date);
}
func getDateYearFormat_ddMMYYY(stringDate: String) -> String
{
    let df  = DateFormatter()
    df.dateFormat = "YYYY-MM-dd"
    let date = df.date(from: stringDate)!
    df.dateFormat = "dd-MM-YYYY"
    return df.string(from: date);
}
func getTodayDate() -> String
{
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    return formatter.string(from: date);
}
