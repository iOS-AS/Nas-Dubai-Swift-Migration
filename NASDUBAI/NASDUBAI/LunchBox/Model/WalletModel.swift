//
//  WalletModel.swift
//  NAS
//
//  Created by Naveeth Parvege on 01/05/21.
//

import UIKit
import ObjectMapper

class WalletModel: Mappable{
    
    var topup_limit : Int?
    var wallet_amount : Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        topup_limit <- map["topup_limit"]
        wallet_amount <- map["wallet_amount"]
    }
}
