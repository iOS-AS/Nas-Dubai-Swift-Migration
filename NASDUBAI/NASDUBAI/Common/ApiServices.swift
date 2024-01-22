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
    
    var headers: HTTPHeaders {
        get {
            return ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        }
    }
    private var tokenCallCount = 0
    private var tokenTime = 300 // seconds
    private var timer: Timer?

    
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
    
    @objc private func tokenCountDownStart() {
        tokenTime -= 1
        if tokenTime == 0 {
            resetTokenCount()
            getAccessToken { }
        }
    }
    private func checkTokenCount() -> Bool {
        if tokenCallCount >= 5 {
            if timer == nil {
                print("Initialize Timer")
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tokenCountDownStart), userInfo: nil, repeats: true)
                UIApplication.topMostViewController?.view?.stopActivityIndicator()
                alertMessage.value = "Some error occurred, Please try again later."
            }
            return false
        } else {
            tokenCallCount += 1
            return true
        }
    }
    
    private func resetTokenCount() {
        tokenTime = 300
        tokenCallCount = 0
        timer?.invalidate()
        timer = nil
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
    
    // Early Years
    func getDepartmentEarlyListFromAPI(completion: @escaping (EarlyListData) -> ()) {
        if !checkReachability() {
            return
        }//EarlyListModelData
        let url = BASE_URL + "departmentearly"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(EarlyListData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.getDepartmentEarlyListFromAPI() { (completed) in
                                
                            }
                        }
                    } else if res.status != 101 || res.status != 102 {
                        DispatchQueue.main.async {
                            print("Function: \(#function), line: \(#line)")
                            completion(res)
                            UIApplication.topMostViewController?.view.stopActivityIndicator()
                        }
                    }
                    if res.status == 130 || res.status == 101 || res.status == 102 || res.status == 103 {
                        print("Function: \(#function), line: \(#line)")
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(_):
                print("error getting data")
            }
            
        }
    }
    
    
    func getWholeSchoolComingUpFromAPI(completion: @escaping (EarlyListData) -> ()) {
        if !checkReachability() {
            return
        }//EarlyListModelData
        let url = BASE_URL + "whole_school_coming_up"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(EarlyListData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.getWholeSchoolComingUpFromAPI() { (completed) in
                                
                            }
                        }
                    } else if res.status != 101 || res.status != 102 {
                        DispatchQueue.main.async {
                            print("Function: \(#function), line: \(#line)")
                            completion(res)
                            UIApplication.topMostViewController?.view.stopActivityIndicator()
                        }
                    }
                    if res.status == 130 || res.status == 101 || res.status == 102 || res.status == 103 {
                        print("Function: \(#function), line: \(#line)")
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(_):
                print("error getting data")
            }
            
        }
    }
    
    //MARK: - Get Early ComingUp
    func getEarlyComingUpFromAPI(completion: @escaping (EarlyComingUpData) -> ()) {
        if !checkReachability() {
            return
        }//EarlyListModelData
        let url = BASE_URL + "early_coming_up"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            DispatchQueue.main.async {
                UIApplication.topMostViewController?.view.stopActivityIndicator()
            }
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(EarlyComingUpData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.getEarlyComingUpFromAPI() { (completed) in
                                
                            }
                        }
                    } else if res.status != 101 || res.status != 102 {
                        DispatchQueue.main.async {
                            print("Function: \(#function), line: \(#line)")
                            completion(res)
                            UIApplication.topMostViewController?.view.stopActivityIndicator()
                        }
                    }
                    if res.status == 130 || res.status == 101 || res.status == 102 || res.status == 103 {
                        print("Function: \(#function), line: \(#line)")
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(_):
                print("error getting data")
            }
            
        }
    }
    
    //MARK: - Get Primary ComingUp
    func getPrimaryComingUpFromAPI(completion: @escaping (EarlyComingUpData) -> ()) {
        if !checkReachability() {
            return
        }//EarlyListModelData
        let url = BASE_URL + "primary_coming_up"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            DispatchQueue.main.async {
                UIApplication.topMostViewController?.view.stopActivityIndicator()
            }
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(EarlyComingUpData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.getPrimaryComingUpFromAPI() { (completed) in
                                
                            }
                        }
                    } else if res.status != 101 || res.status != 102 {
                        DispatchQueue.main.async {
                            print("Function: \(#function), line: \(#line)")
                            completion(res)
                            UIApplication.topMostViewController?.view.stopActivityIndicator()
                        }
                    }
                    if res.status == 130 || res.status == 101 || res.status == 102 || res.status == 103 {
                        print("Function: \(#function), line: \(#line)")
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(_):
                print("error getting data")
            }
            
        }
    }
    
    //MARK: - Get secondary ComingUp
    func getSecondaryComingUpFromAPI(completion: @escaping (EarlyComingUpData) -> ()) {
        if !checkReachability() {
            return
        }//EarlyListModelData
        let url = BASE_URL + "secondary_coming_up"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            DispatchQueue.main.async {
                UIApplication.topMostViewController?.view.stopActivityIndicator()
            }
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(EarlyComingUpData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.getSecondaryComingUpFromAPI() { (completed) in
                                
                            }
                        }
                    } else if res.status != 101 || res.status != 102 {
                        DispatchQueue.main.async {
                            print("Function: \(#function), line: \(#line)")
                            completion(res)
                            UIApplication.topMostViewController?.view.stopActivityIndicator()
                        }
                    }
                    if res.status == 130 || res.status == 101 || res.status == 102 || res.status == 103 {
                        print("Function: \(#function), line: \(#line)")
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(_):
                print("error getting data")
            }
            
        }
    }
    // Login
    
    func callLoginAPI(email: String, password: String, completion: @escaping (Login) -> ()) {
        UIApplication.topMostViewController?.view.startActivityIndicator()
        if !checkReachability() {
            return
        }
        if let token = Messaging.messaging().fcmToken {
            print("token   \(token)")
            DefaultsWrapper().setFCM(token)
        }
        var tokenValue = DefaultsWrapper().getFCM()
        #if DEBUG
        ///Token is the FCM token, used for push notification.
        ///For simulators sometimes we won't get token value so setting a dummy value.
        if tokenValue == "" {
            tokenValue = "ahsgdjkasgdkghajksdhkashdkjhk"
        }
        #endif
        let url = BASE_URL + "login"
        let parameters: Parameters = ["email": email,
                                      "password": password,
                                      "device_type": 1,
                                      "device_identifier": UUID().uuidString,
                                      "device_id": tokenValue]
        print(parameters)
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
                        UIApplication.topMostViewController?.view.stopActivityIndicator()
                    }
                    if res.status == 100 || res.status == 111 {
                        DispatchQueue.main.async {
                            print("Function: \(#function), line: \(#line)")
                            completion(res)
                            UIApplication.topMostViewController?.view.stopActivityIndicator()
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                    UIApplication.topMostViewController?.view.stopActivityIndicator()
                }
            case .failure(_):
                print("error getting data")
                UIApplication.topMostViewController?.view.stopActivityIndicator()
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
   
    func getAccessToken(completion: @escaping () -> ()) {
        let val = checkTokenCount()
        if val {
            let url = BASE_URL + "user/token"
            let header: HTTPHeaders = ["authorization-user" : DefaultsWrapper().getUserCode()]
            print(header)
            AF.request(url, method: .post, headers: header).responseJSON { (response) in
                UIApplication.topMostViewController?.view?.stopActivityIndicator()
                //                print(JSON(response.data ?? Data()))
                switch response.result {
                case .success(_):
                    let decoder = JSONDecoder()
                    do {
                        let res = try decoder.decode(TokenModel.self, from: response.data!)
                        if res.status == 100 {
                            DefaultsWrapper().setAccessToken(res.token ?? "")
                            self.resetTokenCount()
                            completion()
                            UIApplication.topMostViewController?.view?.stopActivityIndicator()
                        }
                        if res.status == 130 || res.status == 101 || res.status == 102 || res.status == 103 {
                            print("Function: \(#function), line: \(#line)")
                        }
                    } catch {
                        print(error.localizedDescription)
                        UIApplication.topMostViewController?.view?.stopActivityIndicator()
                    }
                case .failure(_):
                    print("error getting data")
                    UIApplication.topMostViewController?.view?.stopActivityIndicator()
                }
            }
        }
    }
}
