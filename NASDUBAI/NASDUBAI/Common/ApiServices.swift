//
//  ApiServices.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 19/12/23.
//
import Foundation
import Alamofire
import PassKit
import Firebase


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
    
    let BASE_URL = "http://gama.mobatia.in:8080/NasDubai2023/public/Api-V1/"
    @objc static func checkReachability() -> Bool {
//        if !NetworkManager.shared.reachabilityManager!.isReachable {
//            alertMessage.value = "Network not available."
//            return false
//        } else {
//            return true
//        }
        return true
    }
    func checkReachability() -> Bool {
//        if let reachability = NetworkManager.shared.reachabilityManager?.isReachable {
//            if !reachability {
//                alertMessage.value = "Network not available."
//                return false
//            } else {
//                return true
//            }
//        } 
//        else {
//
//        }
        return true
    }
    
    func callSignupAPI(email: String, completion: @escaping (Login) -> ()) {
//        if !checkReachability() {
//            return
//        }
//        let url = BASE_URL + "parent-signup"
//        let parameters: Parameters = ["email": email]
//        UIApplication.topMostViewController?.view.startActivityIndicator()
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { [self] (response) in
//            DispatchQueue.main.async {
//                UIApplication.topMostViewController?.view.stopActivityIndicator()
//            }
//            print(JSON(response.data ?? Data()))
//            switch response.result {
//            case .success(_):
//                let decoder = JSONDecoder()
//                do {
//                    let res = try decoder.decode(Login.self, from: response.data!)
//                    performOperation(status: res.status!)
//                    if res.status == 130 || res.status == 101 || res.status == 102 || res.status == 103 {
//                        print("Function: \(#function), line: \(#line)")
//                    }
//                    if res.status == 100 || res.status == 121{
//                        DispatchQueue.main.async {
//                            print("Function: \(#function), line: \(#line)")
//                            completion(res)
//                            UIApplication.topMostViewController?.view.stopActivityIndicator()
//                        }
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                }
//            case .failure(_):
//                print("error getting data")
//            }
//            
//        }
//    }
}
