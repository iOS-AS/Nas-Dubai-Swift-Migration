//
//  MyOrderVM.swift
//  NAS
//
//  Created by Naveeth's on 01/06/21.
//
/*
import UIKit

class MyOrderVM: BaseVM2 {
    
    var model: MyOrder?
    
    init(studID: Int?) {
        super.init()
        self.currentStudentID = studID ?? 0
    }
    
    func initializeData() {
        
    }
    
    func totalNumberOfItems() -> Int? {
        
        var numberOfItems: Int = 0
        let _ = model?.canteen_preorders?.map({ preOrders in
            let count = preOrders.items?.reduce(0) { $0 + ($1.quantity ?? 0) } ?? 0
            numberOfItems = numberOfItems + count
        })
        return numberOfItems
    }
    
    private func insertFooter() {
        
        let _ = model?.canteen_preorders?.map({ preOrder in
            
            let count = preOrder.items?.count ?? 0
            
            if count > 0 {
                
                //Footer
                if let item = BasketItem(JSON: [:]) {
                    item.id = preOrder.id
                    item.typeOfAction = .footer
                    preOrder.items?.insert(item, at: count)
                    //Header
                }
                
                //Header
                if let item = BasketItem(JSON: [:]) {
                    item.id = preOrder.id
                    item.typeOfAction = .header
                    preOrder.items?.insert(item, at: 0)
                    //Header
                }
            }
        })
    }
    
    func callGetOrderItemAPI(completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().getOrderItemList(student_id: currentStudentID) { [weak self] result, response, message in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.model = response as? MyOrder
                self.insertFooter()
                completion(true, message)
                break
            case .failure(_):
                completion(false, message)
                break
            }
        }
    }
    
    //Update Item
    func callEditOrderItemAPI(typeOfAction: TypeOfAction?, item: BasketItem?, completion: @escaping DisplayHandler) {
        
        let quant = typeOfAction == .add ? (item?.quantity ?? 0) + 1 : (item?.quantity ?? 0) - 1
        
        LunchBoxResource2().editOrderItem(orderItem_id: item?.id, quantity: quant) { [weak self] result, response, message in
            
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.updateItem(typeOfAction, item)
                completion(true, message)
                break
            case .failure(_):
                completion(false, message)
                break
            }
        }
    }
    
    private func updateItem(_ typeOfAction: TypeOfAction?, _ item: BasketItem?) {
        
        //        guard var preOrders = model?.canteen_preorders else { return }
        
        let _ = model?.canteen_preorders?.map { obj in
            
            if let item_index = obj.items?.firstIndex(where: { obj_2 in
                obj_2.id == item?.id
            }) {
                
                guard let val = obj.items?[item_index].quantity else { return }
                //Update Quantity
                let quant = (typeOfAction == .add) ? val + 1 : val - 1
                obj.items?[item_index].quantity = quant
                
                /*
                //Update ItemTotal
                let itemPriceInDouble = obj.items?[item_index].priceInDouble ?? 0.0 // Double(obj.items?[item_index].price ?? "0") ?? 0.0
                obj.items?[item_index].item_total = itemPriceInDouble * Double(quant)
                */
                
                //Update Order TotalValue
                let count = obj.items?.reduce(0) { $0 + ($1.item_total ?? 0) } ?? 0
                obj.total_amount = (obj.items?[item_index].priceInDouble ?? 0.0) + count
                //                obj.total_amount = String(itemPriceInDouble + Double(count))
                
                //Remove the item
                if quant == 0 {
                    obj.items?.remove(at: item_index)
                }
                
                //Remove the Section
                if obj.items?.count == 0 {
                    if let preOrderIndex = model?.canteen_preorders?.firstIndex(where: { preOrder in
                        preOrder.id == obj.id
                    }) {
                        model?.canteen_preorders?.remove(at: preOrderIndex)
                    }
                }
                return
            }
        }
    }
    
    //Remove Item
    func callCancelOrderItemAPI(typeOfAction: TypeOfAction?, item: BasketItem?, completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().cancelOrderItem(typeOfAction: typeOfAction, id: item?.id) { [weak self] result, response, message in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.updateItem(typeOfAction, item)
                completion(true, message)
                break
            case .failure(_):
                completion(false, message)
                break
            }
        }
        
        /*
         LunchBoxResource().cancelOrderItem(typeOfAction: typeOfAction, id: item?.id) { [weak self] results, response in
         
         guard let responseDict = response as? [String: Any] else {
         completion(false, ErrorValue.somethingError)
         return
         }
         let message = responseDict[DataKey.message] as? String ?? ErrorValue.somethingError
         
         switch results {
         case .success(_):
         self?.updateItem(typeOfAction, item)
         completion(true, message)
         break
         case .failure(_):
         completion(false, message)
         break
         }
         }
         */
    }
    
    func callCancelOrdersAPI(typeOfAction: TypeOfAction?, item: Any?, completion: @escaping DisplayHandler) {
        //Make Id
        var id: Int?
        if let obj = item as? BasketItem {
            id = obj.id
        }
        if let obj = item as? CanteenPreOrders {
            id = obj.id
        }
        //
        LunchBoxResource2().cancelOrderItem(typeOfAction: typeOfAction, id: id) { result, response, message in
            
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

//TableView
extension MyOrderVM: VMTableViewMethods {
    
    typealias Model = BasketItem

    func numberOfSections() -> Int {
        return model?.canteen_preorders?.count ?? 0
    }
    
    func numberOfItemsInSection(bySection section: Int) -> Int {
        return getSectionItem(section: section)?.items?.count ?? 0
    }
    
    func getItem(byIndexPath indexPath: IndexPath) -> BasketItem? {
        return getSectionItem(section: indexPath.section)?.items?[indexPath.row]
    }
    
    func getSectionItem(section: Int) -> CanteenPreOrders? {
        return model?.canteen_preorders?[section]
    }
    
    func getSectionDate(section: Int) -> String? {
        return getSectionItem(section: section)?.delivery_date
    }
}
*/
