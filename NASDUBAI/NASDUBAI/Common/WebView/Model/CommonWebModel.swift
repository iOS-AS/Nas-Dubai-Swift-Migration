//
//  CommonWebModel.swift
//  BISAD
//
//  Created by Mobatia Cathu 2 on 24/12/20.
//

import Foundation

struct CommonWebModel {

    func processData(data: TermsService?) -> (TermsService?, APIError?) {
        if data?.status == 101 || data?.status == 102 {
            alertMessage.value = K.someErrorOccured
            return (nil, .requestFailed)
        } else if data?.status == 116 {
            return (nil, .tokenExpired)
        } else {
            return (data, nil)
        }
    }

    func setWebViewWithData(data: TermsOfService?) -> String {
        var titleString: String       =  data?.title ?? ""
        var descriptionString: String =  data?.termsOfServiceDescription ?? ""
        titleString = titleString.replacingOccurrences(of: "\n", with: "<br/>")
        titleString = titleString.replacingOccurrences(of: "\r\n", with: "<br>")
        descriptionString = descriptionString.replacingOccurrences(of: "\n", with: "<br/>")
        descriptionString = descriptionString.replacingOccurrences(of: "\r\n", with: "<br>")

        guard let filePath = Bundle.main.path(forResource: "pushHTML", ofType: "html") else { return "" }
            var htmlString = try? String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
            htmlString = htmlString?.replacingOccurrences(of: "####TITLE_STRING####", with: titleString)
            htmlString = htmlString?.replacingOccurrences(of: "####DATE_STRING####", with: "")
            htmlString = htmlString?.replacingOccurrences(of: "<center><img src='####IMAGE_URL####' width='100%', height='auto'>", with: "")
            htmlString = htmlString?.replacingOccurrences(of: "####DESCRIPTION_STRING####", with: descriptionString)
            return htmlString!
    }
}

struct HtmlModel {

//    func setWebViewWithData(detailData: MessageDetailNotification?) -> String {
//        var titleString: String       =  detailData?.title ?? ""
//        var descString: String        =  detailData?.message ?? ""
//        let alert_type: String        =  detailData?.alertType?.lowercased() ?? ""
//        var urlString: String         =  detailData?.url ?? ""
//        let dateString: String        =  detailData?.createdAt?.toDate()?.toFormat("dd-MMM-yyyy hh:mm a") ?? ""
//        titleString = titleString.replacingOccurrences(of: "\n", with: "")
//        titleString = titleString.replacingOccurrences(of: "\r\n", with: "")
//        descString = descString.replacingOccurrences(of: "\n", with: "")
//        descString = descString.replacingOccurrences(of: "\r\n", with: "")
//        urlString = urlString.replacingOccurrences(of: " ", with: "%20")
//        guard let filePath = Bundle.main.path(forResource: "pushHTML", ofType: "html") else { return "" }
//
//        if alert_type == "text" {
//            var htmlString = try? String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
//
//            htmlString = htmlString?.replacingOccurrences(of: "####TITLE_STRING####", with: titleString)
//            htmlString = htmlString?.replacingOccurrences(of: "####DATE_STRING####", with: dateString)
//            htmlString = htmlString?.replacingOccurrences(of: "<center><img src='####IMAGE_URL####' width='100%', height='auto'>", with: "")
//            htmlString = htmlString?.replacingOccurrences(of: "####DESCRIPTION_STRING####", with: descString)
//            return htmlString!
//
//        } else if alert_type  == "image" {
//            var htmlString = try? String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
//            htmlString = htmlString?.replacingOccurrences(of: "####TITLE_STRING####", with: titleString)
//            htmlString = htmlString?.replacingOccurrences(of: "####DATE_STRING####", with: dateString)
//            htmlString = htmlString?.replacingOccurrences(of: "####IMAGE_URL####", with: urlString)
//            htmlString = htmlString?.replacingOccurrences(of: "####DESCRIPTION_STRING####", with: descString)
//            return htmlString!
//        } else if alert_type  == "voice" {
//            return urlString
//        } else if alert_type  == "video" {
//            return urlString
//        }
//        return ""
//
//    }


//    func setWebViewWithTermDate(termDate: TermDatesArray?) -> String {
//        if let t = termDate {
//            var titleString: String       =  t.title ?? ""
//            var messageString: String     =  t.responseArrayDescription ?? ""
//            let imageString: String       =  t.image ?? ""
//            titleString = titleString.replacingOccurrences(of: "\n", with: "<br/>")
//            titleString = titleString.replacingOccurrences(of: "\r\n", with: "<br>")
//            messageString = messageString.replacingOccurrences(of: "\n", with: "<br/>")
//            messageString = messageString.replacingOccurrences(of: "\r\n", with: "<br>")
//
//            guard let filePath = Bundle.main.path(forResource: "termDatesHTML", ofType: "html") else { return "" }
//
//                var htmlString = try? String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
//                htmlString = htmlString?.replacingOccurrences(of: "####TITLE_STRING####", with: titleString)
//                htmlString = htmlString?.replacingOccurrences(of: "####DESCRIPTION_STRING####", with: messageString)
//                htmlString = htmlString?.replacingOccurrences(of: "####IMAGE_URL####", with: imageString)
//            return htmlString ?? ""
//
//        }
//        return ""
//    }

//    func setWebViewWithLetters(letters: LettersArray?) -> String {
//
//        if let t = letters {
//
//            var titleString: String       = t.title ?? ""
//            var messageString: String     = t.message ?? ""
//            let imageString: String       = ""
//
//            titleString = titleString.replacingOccurrences(of: "\n", with: "<br/>")
//            titleString = titleString.replacingOccurrences(of: "\r\n", with: "<br>")
//            messageString = messageString.replacingOccurrences(of: "\n", with: "<br/>")
//            messageString = messageString.replacingOccurrences(of: "\r\n", with: "<br>")
//
//            guard let filePath = Bundle.main.path(forResource: "termDatesHTML", ofType: "html") else { return "" }
//
//                var htmlString = try? String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
//                htmlString = htmlString?.replacingOccurrences(of: "####TITLE_STRING####", with: titleString)
//                htmlString = htmlString?.replacingOccurrences(of: "####DESCRIPTION_STRING####", with: messageString)
//                htmlString = htmlString?.replacingOccurrences(of: "####IMAGE_URL####", with: imageString)
//            return htmlString ?? ""
//
//        }
//        return ""
//    }
}





struct TermsService: Codable {
    var status: Int?
    var responseArray: TermsServiceArray?
}

// MARK: - ResponseArray
struct TermsServiceArray: Codable {
    var termsOfService: TermsOfService?

    enum CodingKeys: String, CodingKey {
        case termsOfService = "terms_of_service"
    }
}

// MARK: - TermsOfService
struct TermsOfService: Codable {
    var termsOfServiceDescription, title: String?

    enum CodingKeys: String, CodingKey {
        case termsOfServiceDescription = "description"
        case title
    }
}
