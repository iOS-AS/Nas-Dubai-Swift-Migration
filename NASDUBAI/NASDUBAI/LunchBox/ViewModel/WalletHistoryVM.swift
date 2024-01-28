//
//  PaymentHistoryVM.swift
//  NAS
//
//  Created by Naveeth's on 13/10/21.
//

import Foundation
/*
class WalletHistoryVM: BaseVM2 {

    var arrayOfItems: [WalletHistoryModel] = []

    func initializeData() {

    }
    //TableView
    func numberOfItems() -> Int {
        return arrayOfItems.count
    }

    func getItem(index: Int) -> WalletHistoryModel? {
        return arrayOfItems[index]
    }

    func callWalletHistory(_ completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().getWalletHistory(id: currentStudentID, page_number: start) { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let arrayOfItems):
                if self.isPaginating {
                    self.arrayOfItems.append(contentsOf: arrayOfItems)
                } else {
                    self.arrayOfItems = arrayOfItems
                }
                completion(true, nil)
                break
            case .failure(let err):
                completion(false, err.message)
                break
            }
        }
    }
}
*/
