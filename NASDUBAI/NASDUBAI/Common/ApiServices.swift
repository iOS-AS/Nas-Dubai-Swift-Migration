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
    var responsecode: String
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
let BASE_URL = "http://gama.mobatia.in:8080/NasDubai2023/public/Api-V1/"
let baseUrl = "http://gama.mobatia.in:8080/NasDubai2023/public/Api-V1/"

let URL_NOTIFICATION = baseUrl+"notifications_V1"

@objc class ApiServices: NSObject {
    
    
    var headers: HTTPHeaders {
        get {
            return ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        }
    }
    var statValue : Int?
    //let reEnrollmnt = ReEnrollmentTableView()
    func getStatusMessage(status: String) -> String {
        switch status {
        case "100":
            return "Success"
        case "101":
            return "Some error occured"
        case "102":
            return "Internal server error"
        case "103":
            return "validation error"
        case "110":
            return "Invalid username or password"
        case "113":
            return "Verification code not match"
        case "114":
            return "User not found in our database"
        case "116":
            return "Token expired"
        case "123":
            return "Invalid file access"
        case "124":
            return "Route Not Found"
        case "125":
            return "Student not found in our database"
        case "130":
            return "DecryptException Error"
        case "131":
            return "URL or Method Not found"
        case "132":
            return "No records found"
        case "133":
            return "Restricted access"
        case "134":
            return "Method Not Allowed"
        case "104":
            return "field required"
        case "105":
            return "exists"
        case "106":
            return "not a valid email"
        case "107":
            return "not a valid number"
        case "108":
            return "password and confirm password not same"
        case "109":
            return "Old passord doesn't match!"
        case "111":
            return "No student are linking with that users"
        case "115":
            return "Invalid file type"
        case "117":
            return "not a valid date"
        case "120":
            return "Please enter a valid email address."
        case "121":
            return "The e-mail has already registered."
        case "122":
            return "Not a valid JSON"
        case "126":
            return "File size too large( maxsize:2Mb )"
        default:
            break
        }
        return ""
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
   
    private var tokenCallCount = 0
    private var tokenTime = 300 // seconds
    private var timer: Timer?

    
  
    

    
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
    func registerApp() {
        if let token = Messaging.messaging().fcmToken {
            print("token   \(token)")
            DefaultsWrapper().setFCM(token)
        }
        let url = BASE_URL + "deviceregistration"
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let parameters: Parameters = ["devicetype": 1,
                                      "app_version": appVersion ?? "", "deviceid": UUID().uuidString, "fcm_id": DefaultsWrapper().getFCM()]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            //UIApplication.topMostViewController?.view.stopLoader()
            print("Register App \(JSON(response.data ?? Data()))")
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(BasicModel.self, from: response.data!)
                   /// getStatusMessage(status: res.responsecode ?? "")
                    if res.responsecode == "130" || res.responsecode == "101" || res.responsecode == "102" || res.responsecode == "103" {
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
    
    
    // SignUp
    func callSignupAPI(email: String, completion: @escaping (Login) -> ()) {
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
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let deviceName = UIDevice().getDeviceName()
        let url = BASE_URL + "parent_signup"
    //    let parameters: Parameters = ["email": email]
        let parameters: Parameters = ["email": email,
                                      "devicetype": "1",
                                      "device_name":deviceName,
                                      "deviceid": tokenValue,]
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
                   // performOperation(status: res.status!)
                    if res.responsecode == "130" || res.responsecode == "101" || res.responsecode == "102" || res.responsecode == "103" {
                        print("Function: \(#function), line: \(#line)")
                    }
                    if res.responsecode == "100" || res.responsecode == "121"{
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
        let parameters: Parameters = ["email": email,"deviceid":UUID().uuidString,"devicetype": "1"]
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
                   // performOperation(status: res.responsecode)
                    if res.responsecode == "130" || res.responsecode == "101" || res.responsecode == "102" || res.responsecode == "103" {
                        print("Function: \(#function), line: \(#line)")
                    }
                    if res.responsecode == "100" {
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
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let deviceName = UIDevice().getDeviceName()
        let url = BASE_URL + "login"
        let parameters: Parameters = ["email": email,
                                      "password": password,
                                      "devicetype": "1",
                                      "device_name":deviceName,
                                      "deviceid": tokenValue,"app_version":appVersion]
                
       // print(parameters)
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
                   // performOperation(status: res.status!)
                    if res.response?.statuscode == "305" || res.response?.statuscode == "101" || res.response?.statuscode == "102" || res.response?.statuscode == "103" {
                        print("Function: \(#function), line: \(#line)")
                        UIApplication.topMostViewController?.view.stopActivityIndicator()
                    }
                    if res.response?.statuscode == "303" {
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
    // Submit ReEnrollment Data
    
    func sumitReEnrollment(dataValue: String, completion: @escaping (ReEnrollment) -> ()) {
        if !checkReachability() {
            return
        }
        
        let jsonData = dataValue.data(using: .utf8, allowLossyConversion: false)!
        let apiToken = "Bearer \(DefaultsWrapper().getAccessToken())"
        
        let headers = [
            "Authorization": apiToken,
            "content-type": "application/json"
        ]
        
        let urlMain = URL(string: BASE_URL + "save_re_enrollment")! //PUT Your URL
        var request = URLRequest(url: urlMain)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? NSDictionary {
                
                //  print(responseJSON) //Code after Successfull POST Request
                
                let sstatValue = responseJSON.object(forKey: "status") as! Int
                let msgValue = responseJSON.object(forKey: "message")
                
                
                if sstatValue as! Int == 100{
                    
                    
                    DefaultsWrapper().setStatusType(sstatValue)
                    
                    // self.reEnrollmnt.SubmitDone()
                    
                }
                
            }
        }
        
        task.resume()
        
        
    }
    func getProgressReport(studentID: String, completion: @escaping (ProgressReport) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "progress-reports"
        let parameters: Parameters = ["student_id": studentID]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        print("parameter\(parameters)")
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(ProgressReport.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 130 || res.status == 101 || res.status == 102 || res.status == 103 {
                        print("Function: \(#function), line: \(#line)")
                    }
                    if res.status == 100 || res.status == 103{
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
    //MARK: - Get Canteen Banner Data
    func getCanteenBannerData(completion: @escaping (PaymentBannerData) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "canteen_banner"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(PaymentBannerData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
//                        getAccessToken { [weak self] in
//                            self?.getPaymentBannerData() { (completed) in
//
//                            }
//                        }
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
    //MARK: - Get Canteen Information
    func getCanteenInformationData(completion: @escaping (InformationData) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "canteen_information"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(InformationData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
//                        getAccessToken { [weak self] in
//                            self?.getPaymentInformationData() { (completed) in
//
//                            }
//                        }
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
    
    //MARK: - Edit Preorder Individual Item
    func editPreorderIndividualItem(studentID: String, canteen_preorder_id: String, qunatity: String, completion: @escaping (StatusData) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "edit_canteen_preorder_item"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        let parameters: Parameters = ["studentId": studentID, "quantity": qunatity, "canteen_preorder_item_id": canteen_preorder_id]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(StatusData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.editPreorderIndividualItem(studentID: studentID, canteen_preorder_id: canteen_preorder_id, qunatity: qunatity) { (completed) in
                                
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
    
    //MARK: - Cancel Preorder Individual Item
    func cancelPreorderIndividualItem(studentID: String, canteen_preorder_id: String, completion: @escaping (StatusData) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "cancel_canteen_preorder_item"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        let parameters: Parameters = ["studentId": studentID, "canteen_preorder_item_id": canteen_preorder_id]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(StatusData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.cancelPreorderIndividualItem(studentID: studentID, canteen_preorder_id: canteen_preorder_id) { (completed) in
                                
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
    
    //MARK: - Cancel Preorder Data
    func cancelPreorderData(studentID: String, canteen_preorder_id: String, completion: @escaping (StatusData) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "cancel_canteen_preorder"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        let parameters: Parameters = ["studentId": studentID, "canteen_preorder_id": canteen_preorder_id]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(StatusData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.cancelPreorderData(studentID: studentID, canteen_preorder_id: canteen_preorder_id) { (completed) in
                                
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
    
    //MARK: - Update Preorder Data
    func updatePreorderData(dataStr: [String: Any], completion: @escaping (StatusData) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "canteen_preorder"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        let parameters: Parameters = dataStr
        print(dataStr)
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(StatusData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.updatePreorderData(dataStr: dataStr) { (completed) in
                                
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
    
    //MARK: - Get Preorder History Info
    func getPreorderHistoryInfo(studentID: String, completion: @escaping (PreorderData) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "get_canteen_preorder_history"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        let parameters: Parameters = ["studentId": studentID, "limit": "100", "start": "0"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(PreorderData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.getPreorderHistoryInfo(studentID: studentID) { (completed) in
                                
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
    
    //MARK: - Get Preorder Info
    func getPreorderInfo(studentID: String, completion: @escaping (PreorderData) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "get_canteen_preorder"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        let parameters: Parameters = ["studentId": studentID, "limit": "100", "start": "0"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(PreorderData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.getPreorderInfo(studentID: studentID) { (completed) in
                                
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
    
    //MARK: - Get Food Categories
    func getFoddCategories(completion: @escaping (FoodItemsCategoriesResponse) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "get_canteen_categories"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    guard let dictResponse =  try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any], let status = dictResponse["status"] as? Int
                    else {
                        return
                    }
                    performOperation(status: status)
                    if status == 116 {
                        getAccessToken { [weak self] in
                            self?.getFoddCategories() { (completed) in
                                
                            }
                        }
                    } else if status != 101 || status != 102 {
                        DispatchQueue.main.async {
                            print("Function: \(#function), line: \(#line)")
                            let obj = FoodItemsCategoriesResponse(dictResponse)
                            completion(obj)
                            UIApplication.topMostViewController?.view.stopActivityIndicator()
                        }
                    }
                    if status == 130 || status == 101 || status == 102 || status == 103 {
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
    
    //MARK: - Get Preorder Info
    func callFoodItems(studentID: String, category_id: Int, order_date: String, andLimit: String, andSkip: String, completion: @escaping (ItemsAPIResponce) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "get_canteen_items"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        let parameters: Parameters = ["studentId": studentID, "limit": andLimit,
                                      "start": andSkip, "category_id":category_id,
                                      "order_date": order_date]
        if andSkip == "0" {
            UIApplication.topMostViewController?.view.startActivityIndicator()
        }
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    guard let dictResponse =  try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any], let status = dictResponse["status"] as? Int
                    else {
                        return
                    }
                    performOperation(status: status)
                    if status == 116 {
                        getAccessToken { [weak self] in
                            self?.callFoodItems(studentID: studentID, category_id: category_id, order_date: order_date, andLimit: andLimit, andSkip: andSkip) { (completed) in
                                
                            }
                        }
                    } else if status != 101 || status != 102 {
                        DispatchQueue.main.async {
                            print("Function: \(#function), line: \(#line)")
                            let obj = ItemsAPIResponce(dictResponse)
                            completion(obj)
                            if andSkip == "0" {
                                UIApplication.topMostViewController?.view.stopActivityIndicator()
                            }
                        }
                    }
                    if status == 130 || status == 101 || status == 102 || status == 103 {
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
    
    
    //MARK: - Call Add Cart
    func callAdd(dataDict: [String:Any], completion: @escaping (StatusData) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "add_to_canteen_cart"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        let parameters: Parameters = dataDict
        print(dataDict)
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(StatusData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.callAdd(dataDict: dataDict) { (completed) in
                                
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
    
    //MARK: - Call Delete Cart Items
    func callDeleteCartItemsAPI(studentId: String, canteen_cart_id: String, completion: @escaping (StatusData) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "remove_canteen_cart"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        let parameters: Parameters = ["studentId": studentId, "canteen_cart_id": canteen_cart_id]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(StatusData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.callDeleteCartItemsAPI(studentId: studentId, canteen_cart_id: canteen_cart_id) { (completed) in
                                
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
    
    //MARK: - Call Update Cart
    func callUpdateCart(dataDict: [String:Any], completion: @escaping (StatusData) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "update_canteen_cart"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        let parameters: Parameters = dataDict
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(StatusData.self, from: response.data!)
                    performOperation(status: res.status!)
                    if res.status == 116 {
                        getAccessToken { [weak self] in
                            self?.callUpdateCart(dataDict: dataDict) { (completed) in
                                
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
    
    //MARK: - Canteen Cart List API
    func getCanteenCartListAPI(studentID: String, completion: @escaping (CartListResponse) -> ()) {
        if !checkReachability() {
            return
        }
        let url = BASE_URL + "get_canteen_cart"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        let parameters: Parameters = ["studentId": studentID]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    guard let dictResponse =  try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any], let status = dictResponse["status"] as? Int
                    else {
                        return
                    }
                    performOperation(status: status)
                    if status == 116 {
                        getAccessToken { [weak self] in
                            self?.getCanteenCartListAPI(studentID: studentID, completion: { completed in
                                
                            })
                        }
                    } else if status != 101 || status != 102 {
                        DispatchQueue.main.async {
                            print("Function: \(#function), line: \(#line)")
                            let obj = CartListResponse(dictResponse)
                            completion(obj)
                            UIApplication.topMostViewController?.view.stopActivityIndicator()
                        }
                    }
                    if status == 130 || status == 101 || status == 102 || status == 103 {
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
    
    
    func getHomeBanners(completion: @escaping (Banner) -> ()) {
        
        let url = BASE_URL + "banner_images"
        AF.request(url, method: .post, encoding: JSONEncoding.default).responseJSON { [self] (response) in
            UIApplication.topMostViewController?.view.stopActivityIndicator()
            print("banner_images api response: \(JSON(response.data ?? Data()))")
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(Banner.self, from: response.data!)
                    performOperation(status: res.status ?? 0)
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
                    UIApplication.topMostViewController?.view.stopActivityIndicator()
                }
            case .failure(_):
                print("error getting data")
                UIApplication.topMostViewController?.view.stopActivityIndicator()
            }
            
        }
    }
    
    func getStudentList(completion: @escaping (Student) -> ()) {
        
        let url = BASE_URL + "studentlist"
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let parameters: Parameters = ["devicetype": 1,
                                      "app_version": appVersion ?? ""]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            DispatchQueue.main.async {
                UIApplication.topMostViewController?.view.stopActivityIndicator()
            }
         //   print(JSON(response.data ?? Data()))
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    let res = try decoder.decode(Student.self, from: response.data!)
                   
                    getStatusMessage(status: res.responsecode ?? "")
                    if res.responsecode == "200"{
                        DispatchQueue.main.async {
                            print("Function: \(#function), line: \(#line)")
                            completion(res)
                            UIApplication.topMostViewController?.view.stopActivityIndicator()
                        }
                    }
                    if res.responsecode == "130" || res.responsecode == "101" || res.responsecode == "102" || res.responsecode == "103" {
                        print("Function: \(#function), line: \(#line)")
                        UIApplication.topMostViewController?.view.stopActivityIndicator()
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

}
