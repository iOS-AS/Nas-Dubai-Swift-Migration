//
//  ApiServices.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 19/12/23.
//
import Foundation
import Alamofire

struct BasicModel: Codable {
    var status: Int
}


struct TokenModel: Codable {
    var status: Int
    var token: String?
}

enum Result<T, U> where U:Error {
    case success(T)
    case failure(U)
}


enum APIError: Error {
    case tokenExpired
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .tokenExpired: return "Access token Expired"
        case .requestFailed: return "Request Failed"
        case .invalidData: return "quot;Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

@objc class ApiServices: NSObject {
    
}
