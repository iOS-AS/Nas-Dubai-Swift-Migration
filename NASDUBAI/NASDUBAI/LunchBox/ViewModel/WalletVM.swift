//
//  WalletVM.swift
//  NAS
//
//  Created by Naveeth Parvege on 24/05/21.
//
/*
import UIKit
import ObjectMapper
import NISdk


class WalletVM: BaseVM2 {
    
    var model: WalletModel?
    var amount: String = ""
    
    var orderResponse: OrderResponse?
    var order_id: Int?
    
    func initializeData() {
        setFirstStudentID()
    }
    
    func setValue(amount: String) {
        self.amount = amount
    }
    
    func updateWallet() {
        
        let newAmount = Int(amount) ?? 0
        model?.wallet_amount = (model?.wallet_amount ?? 0) + newAmount
    }
    
    func resetAmountField() {
        amount = ""
    }
    
    func getWalletAmount() -> String? {
        
        if let amount = model?.wallet_amount {
            let output = "\(amount)" + " AED"
            return output
        }
        
        return ""
    }
    
    func isValidAmount(_ newAmount: Int) -> Bool {
        
        guard let maxAmt = model?.topup_limit, maxAmt > 0 else { return false }
        guard let amount = (model?.wallet_amount) else { return false }
        let total = amount + newAmount
        return total <= maxAmt
    }
    
    func callAPI(completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().getWalletDetails(student_id: currentStudentID) { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let val):
                self.model = val
                completion(true, nil)
                break
            case .failure(let err):
                completion(false, err.message)
                break
            }
        }
    }
    
    func callGetWalletOrder(completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().getWalletOrder(student_id: currentStudentID,
                                           amount: amount) { [weak self] result, response, message in
            
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                guard let dict = response as? [String: Any], let orderDetail = dict[DataKey.order_detail] as? [String: Any] else {
                    completion(false, ErrorValue.somethingError)
                    return
                }
                //Converting to responseData
                guard let dictData = try? JSONSerialization.data(withJSONObject: orderDetail, options: .prettyPrinted)  else {
                    completion(false, ErrorValue.somethingError)
                    return
                }
                //Loading the responseData to ListModel
                let jsonDecoder = JSONDecoder()
                guard let model = try? jsonDecoder.decode(OrderResponse.self, from: dictData) else {
                    completion(false, ErrorValue.somethingError)
                    return
                }
                self.orderResponse = model
                completion(true, message)
                break
            case .failure(_):
                completion(false, message)
                break
            }
        }
        
        /*
         LunchBoxResource().getWalletOrder(student_id: currentStudentID, amount: amount) { [weak self] success, response, error in
         
         //Checking response as Dictionary
         guard let responseDict = response as? [String: Any] else {
         completion(false, ErrorValue.somethingError)
         return
         }
         
         //Fetching the data key
         guard let dict = responseDict[DataKey.data] as? [String: Any] else {
         completion(false, ErrorValue.somethingError)
         return
         }
         
         //Setting OrderID
         self?.order_id = dict["order_id"] as? Int ?? 0
         
         //
         guard let orderDetail = dict[DataKey.order_detail] as? [String: Any] else {
         completion(false, ErrorValue.somethingError)
         return
         }
         
         //Converting to responseData
         guard let dictData = try? JSONSerialization.data(withJSONObject: orderDetail, options: .prettyPrinted)  else {
         completion(false, ErrorValue.somethingError)
         return
         }
         
         //Loading the responseData to ListModel
         let jsonDecoder = JSONDecoder()
         guard let model = try? jsonDecoder.decode(OrderResponse.self, from: dictData) else {
         completion(false, ErrorValue.somethingError)
         return
         }
         
         self?.orderResponse = model
         completion(true, DefaultValue.success)
         }
         */
    }
    
    func callWalletSubmissionAPI(completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().walletSubmissionAPI(order_id: order_id) { result, response, message in
            
            switch result {
            case .success(_):
                completion(true, message)
                break
            case .failure(_):
                completion(false, message)
                break
            }
        }
    }
}
*/
