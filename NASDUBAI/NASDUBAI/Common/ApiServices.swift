//
//  ApiServices.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 19/12/23.
//
import Foundation
import Alamofire
import SwiftyJSON
import NISdk
import PassKit
import Firebase
import ObjectMapper


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
        if !NetworkManager.shared.reachabilityManager!.isReachable {
            alertMessage.value = "Network not available."
            return false
        } else {
            return true
        }
//        return true
    }
    func checkReachability() -> Bool {
        if let reachability = NetworkManager.shared.reachabilityManager?.isReachable {
            if !reachability {
                alertMessage.value = "Network not available."
                return false
            } else {
                return true
            }
        } 
        else {
               return true

        }
            }
    
    
    // SignUp
    func callSignupAPI(email: String, completion: @escaping (Login) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "parent_signup"
        let parameters: Parameters = ["email": email]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { [self] (response) in
            DispatchQueue.main.async {
                UIApplication.topMostViewController?.view.stopActivityIndicator()
            }
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(Login.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 130 || res.status == 101 || res.status == 102 || res.status == 103 {
                        print("Function: \(#function), line: \(#line)")
                    }
                    if res.status == 100 || res.status == 121{
                        DispatchQueue.main.async {
                            print("Function: \(#function), line: \(#line)")
                            completion(res)
                            UIApplication.topMostViewController?.view.stopActivityIndicator()
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(_):
                print("error getting data")
            }
            
        }
    }
    
    // Forgot Password
    
    func callForgotPwAPI(email: String, completion: @escaping (ForgotPassword) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "forgotpassword"
        let parameters: Parameters = ["email": email]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { [self] (response) in
            DispatchQueue.main.async {
                UIApplication.topMostViewController?.view.stopActivityIndicator()
            }
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(ForgotPassword.self, from: response.data!)
                    performOperation(status: res.status)
                    if res.status == 130 || res.status == 101 || res.status == 102 || res.status == 103 {
                        print("Function: \(#function), line: \(#line)")
                    }
                    if res.status == 100 {
                        DispatchQueue.main.async {
                            print("Function: \(#function), line: \(#line)")
                            completion(res)
                            UIApplication.topMostViewController?.view.stopActivityIndicator()
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(_):
                print("error getting data")
            }
            
        }
    }
    
    
    
    
    func performOperation(status: Int) {
        UIApplication.topMostViewController?.view.stopActivityIndicator()
        switch status {
        case 100:
            print("Success")
        case 101:
            print("Some error occured")
        case 102:
            print("Internal server error")
        case 103:
            print("validation error")
        case 110:
            alertMessage.value = "Invalid username or password"
            print("Invalid username or password")
        case 113:
            alertMessage.value = "Invalid username or password"
            print("Verification code not match")
        case 114:
            alertMessage.value = "Invalid username or password"
            print("User not found in our database")
        case 116:
            print("Token expired")
            UIApplication.topMostViewController?.view.startActivityIndicator()
        case 123:
            print("Invalid file access")
        case 124:
            print("Route Not Found")
        case 125:
            print("Student not found in our database")
        case 130:
            print("DecryptException Error")
        case 131:
            print("URL or Method Not found")
        case 132:
            //            alertMessage.value = "Invalid username or password"
            print("No records found")
        case 133:
            print("Restricted access")
        case 134:
            print("Method Not Allowed")
        case 104:
            print("field required")
        case 105:
            print("exists")
        case 106:
            print("not a valid email")
        case 107:
            print("not a valid number")
        case 108:
            print("password and confirm password not same")
        case 109:
            print("Old passord doesn't match!")
        case 111:
            print("No student are linking with that users")
        case 115:
            print("Invalid file type")
        case 117:
            print("not a valid date")
        case 120:
            print("Please enter a valid email address.")
        case 121:
            
            print("The e-mail has already registered.")
        case 122:
            print("Not a valid JSON")
        case 126:
            print("File size too large( maxsize:2Mb )")
        default:
            break
        }
    }
}
