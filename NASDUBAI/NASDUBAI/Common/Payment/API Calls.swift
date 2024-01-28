//
//  API Calls.swift
//  NetworkPaymentTest
//
//  Created by sigosoft on 14/09/20.
//  Copyright © 2020 Stebin. All rights reserved.
//

import UIKit
import NISdk
import PassKit
import Alamofire
class APICalls {
    
    let accessTokenUrlString =  ApiServices().BASE_URL + "network_payment_gateway_access_token"
    let creatingOrderUrlString = ApiServices().BASE_URL + "canteen_wallet_order"
    let accessTokenUrlString_Fee_Payment = ApiServices().BASE_URL + "network_payment_gateway_access_token_for_fee_payment"
    let creatingOrderUrlString_Fee_Payment =  ApiServices().BASE_URL + "network_payment_gateway_creating_an_order_for_fee_payment"
    
//    // Dev https url
//    let accessTokenUrlString =  "https://beta.mobatia.in:8888/naisV4.1/api/network_payment_gateway_access_token"
//    let creatingOrderUrlString = "https://beta.mobatia.in:8888/naisV4.1/api/canteen_wallet_order"
//    let accessTokenUrlString_Fee_Payment = "https://beta.mobatia.in:8888/naisV4.1/api/network_payment_gateway_access_token_for_fee_payment"
//    let creatingOrderUrlString_Fee_Payment = "https://beta.mobatia.in:8888/naisV4.1/api/network_payment_gateway_creating_an_order_for_fee_payment"
    
    
////    Dev
//    let accessTokenUrlString =  "http://beta.mobatia.in:81/naisV4.1/api/network_payment_gateway_access_token"
////    let creatingOrderUrlString = "http://beta.mobatia.in:81/naisV4.1/api/network_payment_gateway_creating_an_order"
//    let creatingOrderUrlString = "http://beta.mobatia.in:81/naisV4.1/api/canteen_wallet_order"
//    let accessTokenUrlString_Fee_Payment = "http://beta.mobatia.in:81/naisV4.1/api/network_payment_gateway_access_token_for_fee_payment"
//    let creatingOrderUrlString_Fee_Payment = "http://beta.mobatia.in:81/naisV4.1/api/network_payment_gateway_creating_an_order_for_fee_payment"
    
    
    
//    Live
//    let accessTokenUrlString = "https://cms.nasdubai.ae/nais/api/network_payment_gateway_access_token"
//    let creatingOrderUrlString = "https://cms.nasdubai.ae/nais/api/canteen_wallet_order"
//    let accessTokenUrlString_Fee_Payment = "https://cms.nasdubai.ae/nais/api/network_payment_gateway_access_token_for_fee_payment"
//    let creatingOrderUrlString_Fee_Payment = "https://cms.nasdubai.ae/nais/api/network_payment_gateway_creating_an_order_for_fee_payment"
   
    var NPGAccessToken = ""
    
    func generateNPGAccessToken(completion: @escaping () -> ()){
        
        guard let url = URL(string: accessTokenUrlString) else { return }
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(DefaultsWrapper().getAccessToken() ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil { print(error!) }
            guard let safeData = data else { return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(AccessTokenModel.self, from: safeData)
                if let token = decodedData.response?.accessToken {
                    self.NPGAccessToken = token
                    print(token)
                    completion()
                }
            } catch {
                print(error.localizedDescription)
                completion()
            }
        }
        task.resume()
    }
//    func createNPGOrder(amount: Int,emailAddress: String,merchantOrderReference: String,firstName: String,lastName: String,address1: String,city: String,countryCode: String, completion: @escaping (OrderResponse) -> ()){
//        guard let url = URL(string: creatingOrderUrlString) else { return }
//        let session = URLSession(configuration: .default)
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let trimmedString = emailAddress.trimmingCharacters(in: .whitespaces)
//
//        let parameters = "access_token=\(NPGAccessToken)&amount=\(amount)&emailAddress=\(trimmedString)&merchantOrderReference=\(merchantOrderReference)&firstName=\(firstName)&lastName=\(lastName)&address1=\(address1)&city=\(city)&countryCode=\(countryCode)"
//        let postData =  parameters.data(using: .utf8)
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.httpBody = postData
//
//        let task = session.dataTask(with: request) { (data, response, error) in
//            if error != nil { print(error!) }
//            print(String(data: data!, encoding: .utf8)!)
//            guard let safeData = data else { return }
//            let decoder = JSONDecoder()
//            do {
//                let decodedData = try decoder.decode(CreateOrderModel.self, from: safeData)
//                if decodedData.responsecode != "500" {
//                    let orderResponse: OrderResponse = (decodedData.response?.data)!
//                    completion(orderResponse)
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
//    }
    
    func createNPGOrder(amount: Int,studId: String, completion: @escaping (CreateOrderResponse) -> ()){
        guard let url = URL(string: creatingOrderUrlString) else { return }
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
       // let parameters = "amount=\(amount)&student_id=\(studId)&device_type=1&device_name=\(AppDelegate.getDeviceDetails() ?? "")&app_version=\(AppDelegate.getAppverssion() ?? "")"
       // print(parameters)
      //  let postData =  parameters.data(using: .utf8)
        request.setValue("Bearer \(DefaultsWrapper().getAccessToken() ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: Parameters = ["amount": amount,"student_id":studId,"device_type":1, "device_name":  UUID().uuidString,
        "app_version": appVersion]
       let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = postData

        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil { print(error!) }
            print(String(data: data!, encoding: .utf8)!)
            guard let safeData = data else { return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CreateOrderModel.self, from: safeData)
                
                if decodedData.responsecode != "500" {
                    
                    let orderResponse: CreateOrderResponse = (decodedData.response)!
                    
                    print("tokiyo \(orderResponse.order_id ?? "")")
                    
                    completion(orderResponse)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
//    MARK:fee Payment
    func generateNPGAccessToken_Fee_Payment(completion: @escaping () -> ()){
        
        guard let url = URL(string: accessTokenUrlString_Fee_Payment) else { return }
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(DefaultsWrapper().getAccessToken() ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil { print(error!) }
            guard let safeData = data else { return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(AccessTokenModel.self, from: safeData)
                if let token = decodedData.response?.accessToken {
                    self.NPGAccessToken = token
                    print(token)
                    completion()
                }
            } catch {
                print(error.localizedDescription)
                completion()
            }
        }
        task.resume()
    }
    func createNPGOrder_Fee_Payment(amount: Int,emailAddress: String,merchantOrderReference: String,firstName: String,lastName: String,address1: String,city: String,countryCode: String, completion: @escaping (OrderResponse) -> ()){
        guard let url = URL(string: creatingOrderUrlString_Fee_Payment) else { return }
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let trimmedString = emailAddress.trimmingCharacters(in: .whitespaces)

//        let parameters = "access_token=\(NPGAccessToken)&amount=\(amount)&emailAddress=\(trimmedString)&merchantOrderReference=\(merchantOrderReference)&firstName=\(firstName)&lastName=\(lastName)&address1=\(address1)&city=\(city)&countryCode=\(countryCode)"
//        let postData =  parameters.data(using: .utf8)
        request.setValue("Bearer \(DefaultsWrapper().getAccessToken() ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: Parameters = ["access_token": NPGAccessToken,
            "amount":amount,"emailAddress":"\(trimmedString)",
            "merchantOrderReference":"\(merchantOrderReference)",
            "firstName": firstName,
            "lastName": lastName,
            "address1":address1,
            "city":city,
            "countryCode":countryCode]
       let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = postData

        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil { print(error!) }
         //   print(String(data: data!, encoding: .utf8)!)
            guard let safeData = data else { return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CreateOrderModel.self, from: safeData)
                if decodedData.responsecode != "500" {
                    let orderResponse: OrderResponse = (decodedData.response?.data)!
                    completion(orderResponse)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func createNPGOrderForLostCard(amount: Int,userId: String,studId: String,merchantOrderReference: String,type: String, completion: @escaping (CreateOrderResponse) -> ()){
        guard let url = URL(string: creatingOrderUrlString) else { return }
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
//        let trimmedString = emailAddress.trimmingCharacters(in: .whitespaces)
        request.setValue("Bearer \(DefaultsWrapper().getAccessToken() ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = "amount=\(amount)&student_id=\(studId)&device_type=1&device_name=\( UUID().uuidString)&app_version=\(appVersion)&merchantOrderReference=\(merchantOrderReference)&type=\(type)"
        let postData =  parameters.data(using: .utf8)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData

        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil { print(error!) }
            print(String(data: data!, encoding: .utf8)!)
            guard let safeData = data else { return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CreateOrderModel.self, from: safeData)
                
                if decodedData.responsecode != "500" {
                    
                    let orderResponse: CreateOrderResponse = (decodedData.response)!
                    
                    print("tokiyo \(orderResponse.order_id ?? "")")
                    
                    completion(orderResponse)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

