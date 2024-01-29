//
//  CommonFunctions.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 22/01/24.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON

struct CF {
    static func setStudentImage(_ url: String?, completion: @escaping (UIImage) -> ()) -> UIImage{
        if url != "" {
            SDWebImageManager.shared.loadImage(with: URL(string: url ?? ""), options: .highPriority, progress: nil) { (image, data, err, type, status, url) in
                if err == nil {
                    if let img = image {
                        completion(img)
                    }
                }
            }
            return UIImage(named: "studentIcon.png")!
        } else {
            return UIImage(named: "studentIcon.png")!
        }
    }

    static func isGuestAllowedPage(name: String) -> Bool {
        switch name {
        case "Home":
            return true
        case "Student Information":
            return false
        case "Calendar":
            return false
        case "Notifications":
            return false
        case "Communications":
            return false
        case "Absence & Early Pickup":
            return false
        case "Lunch Box":
            return false
        case "Payment":
            return false
        case "Teacher Contact":
            return false
        case "Social Media":
            return true
        case "Reports":
            return false
        case "Attendance":
            return false
        case "Timetable":
            return false
        case "Forms":
            return false
        case "Term Dates":
            return false
        case "Curriculum":
            return false
        case "Contact Us":
            return true
        case "Apps":
            return false
        case "Early Years":
            return false
        case "Primary":
            return false
        case "Secondary":
            return false
        default:
            return false
        }

    }

    static func processResponse<T: Decodable>(_ response: AFDataResponse<Any>, decodingType: T.Type) -> (T?) {
        print(JSON(response.data))
        switch response.result {
        case .success(_):
            let decoder = JSONDecoder()
            do {
                let res = try decoder.decode(T.self, from: response.data!)
                return res
            } catch {
                print(error.localizedDescription)
            }
        case .failure(_):
            print("error getting data")
        }
        return nil
    }
    /*var loginModel = LoginModel()
    var dcModel = DCModel()
    func forceLogout() {
        loginModel.deleteRecords()
        dcModel.deleteOwnDetailsFromCoreData()
        dcModel.deleteKinDetailsFromCoreData()
        dcModel.deletePassportDetailsFromCoreData()
        dcModel.deleteHealthInsuranceDetailsFromCoreData()
        dcModel.deleteStudentDetailsFromCoreData()
        DefaultsWrapper().clearData()
//                    let domain = Bundle.main.bundleIdentifier!
//                    UserDefaults.standard.removePersistentDomain(forName: domain)
//                    UserDefaults.standard.synchronize()
//                    print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        pushToLogin()
    }*/
}


class Helper {

//static func changeDateFormat(dateString: String, fromFormat: String, toFormat: String) ->String {
//    let inputDateFormatter = DateFormatter()
//    inputDateFormatter.dateFormat = fromFormat
//    let date = inputDateFormatter.date(from: dateString)
//
//    let outputDateFormatter = DateFormatter()
//    outputDateFormatter.dateFormat = toFormat
//    return outputDateFormatter.string(from: date!)
//}
    
    static func changeDateFormat(dateString: String, fromFormat: String, toFormat: String) -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = fromFormat
        guard let date = inputDateFormatter.date(from: dateString) else {
            print("Error: Unable to parse date from the input string.")
            return nil
        }

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = toFormat
        return outputDateFormatter.string(from: date)
    }
    
}

extension UILabel {
    func setMargins(_ margin: CGFloat = 10) {
        if let textString = self.text {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = margin
            paragraphStyle.headIndent = margin
            paragraphStyle.tailIndent = -margin
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}

