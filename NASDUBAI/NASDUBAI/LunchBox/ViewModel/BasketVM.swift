//
//  BasketVM.swift
//  NAS
//
//  Created by Naveeth's on 14/07/21.
//
/*
import Foundation

class BasketVM: BaseVM2, VMTableViewMethods {

    var model: BasketModel?
    
    init(studID: Int?) {
        
        super.init()
        self.currentStudentID = studID ?? 0
    }

    func initializeData() {

    }

    func callGetCardItemAPI(completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().getCardItem(student_id: currentStudentID) { [weak self] result, response, message in
            guard let self = self else { return }
            switch result {
            case .success(_):
                let obj = response as? BasketModel
                self.groupingSameProducts(obj)
                //Update To Realm LunchBoxData
//                LunchCardUtility.sharedInstance.lunchCardData?.updateValue(self.model?.total_items_in_cart ?? 0, self.model?.cart_totoal ?? 0.0)
                completion(true, message)
                break
            case .failure(_):
                completion(false, message)
                break
            }
        }
    }

    //Generate Grouping
    private func groupingSameProducts(_ data: BasketModel?) {

        //Assign data to Model
        model = data

        guard let data = data else { return }
        //
        var cartDetails : [BasketDetail] = []
        let _ = data.cart_details?.map({ obj in
            //Items
            var items : [BasketItem] = []
            let _ = obj.items?.map({ obj_2 in
                //make items
                if items.count > 0 {
                    let _ = items.map { obj_3 in
                        if obj_3.item_id == obj_2.item_id {
                            obj_3.quantity = (obj_3.quantity ?? 0) + 1
                        } else {
                            items.append(obj_2)
                        }
                    }
                } else {
                    items.append(obj_2)
                }
            })
            obj.items = items
            cartDetails.append(obj)
        })
        model?.cart_details = cartDetails
    }

    //UpdateCard
    private func updateCardItemQuantity(typeOfAction: TypeOfAction?, item: BasketItem?, quantity: Int?) {
        
        guard let model = model, let card_details = model.cart_details  else { return }
        
        for (indx, value) in card_details.enumerated() {
            
            if let itemIndex = value.items?.firstIndex(where: { obj in
                obj.id == item?.id
            }) {
                /*
                 //Update To Realm LunchBoxData
                 LunchCardUtility.sharedInstance.lunchCardData?.updateQuantityPrice(typeOfAction, Double(model?.cart_details?[index].items?[itemIndex].price ?? "") ?? 0.0)
                 */
                card_details[indx].items?[itemIndex].quantity = quantity
                
                // Add OR Minus the amount from Total Amount
                if let total_items_in_cart = model.total_items_in_cart {
                    model.total_items_in_cart = typeOfAction == .add ? (total_items_in_cart + 1) : (total_items_in_cart - 1)
                    
                }
                if let cart_totoal = model.cart_totoal, let eachPrice = card_details[indx].items?[itemIndex].priceInDouble {
                    model.cart_totoal = typeOfAction == .add ? (cart_totoal + eachPrice) : (cart_totoal - eachPrice)
                }
                return
            }
        }
    }

    func callUpdateCardItemAPI(typeOfAction: TypeOfAction?, item: BasketItem?, completion: @escaping DisplayHandler) {
        
        var quantity = item?.quantity ?? 0
        quantity = typeOfAction == .add ? quantity + 1 : quantity - 1
        
        LunchBoxResource2().updateCardItem(student_id: currentStudentID,
                                           canteen_cart_id: item?.id,
                                           item_id: item?.item_id,
                                           quantity: quantity) { [weak self] result, response, message in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.updateCardItemQuantity(typeOfAction: typeOfAction, item: item, quantity: quantity)
                completion(true, message)
                break
            case .failure(_):
                completion(false, message)
                break
            }
        }
    }

    //RemoveCard
    private func removeCardItem(item: BasketItem?) {
        
        guard let model = model, let card_details = model.cart_details  else { return }
        //        guard let cardDetails = model?.cart_details else { return }
        
        for (indx, value) in card_details.enumerated() {
            
            if let itemIndex = value.items?.firstIndex(where: { obj in
                obj.id == item?.id
            }) {
                /*
                 //Update To Realm LunchBoxData
                 LunchCardUtility.sharedInstance.lunchCardData?.updateQuantityPrice(.remove, model?.cart_totoal ?? 0.0)
                 */
                
                // Minus the amount from Total Amount
                if let total_items_in_cart = model.total_items_in_cart {
                    model.total_items_in_cart = total_items_in_cart - 1
                }
                if let cart_totoal = model.cart_totoal, let eachPrice = card_details[indx].items?[itemIndex].priceInDouble {
                    model.cart_totoal = cart_totoal - eachPrice
                }
                
                card_details[indx].items?.remove(at: itemIndex)
                
                //If Item is empty then we are removing the particular section
                if card_details[indx].items?.count == 0 {
                    model.cart_details?.remove(at: indx)
                }
                
                return
            }
        }
    }

    func callRemoveCardItemAPI(typeOfAction: TypeOfAction?, item: BasketItem?, completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().removeCardItem(canteen_cart_id: item?.id) { [weak self] result, response, message in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.removeCardItem(item: item)
                completion(true, message)
                break
            case .failure(_):
                completion(false, message)
                break
            }
        }
    }

    //Submit Order
    func callSubmitOrderAPI(completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().updateToCard(params: makeOrderSubmitAPIParameters()) { [weak self] result, response, message in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.removeOrderPlacedItem()
                completion(true, message)
                break
            case .failure(_):
                completion(false, message)
                break
            }
        }
    }

    private func removeOrderPlacedItem() {

        model = nil
//        LunchCardUtility.sharedInstance.lunchCardData?.resetAllValues()
    }

    private func makeOrderSubmitAPIParameters() -> [String: Any] {

        /*Structure
         {
         "student_id": "3189",
         "orders": "[
         {
         'delivery_date':'2021-05-31',
         'items': [
         {
         'item_id':'5568',
         'quantity':'2'},
         {'item_id':'5569',
         'quantity':'1'}
         ]
         }
         ]"
         }
         */

        guard let model = model else { return [:] }

        //Load Orders
        var orders: [[String: Any]] = []
        //Load Items array
        var items: [[String: String]] = []

        let _ = model.cart_details?.map({ obj in

            let _ = obj.items?.map({ obj_2 in
                //Load Item
                let item: [String: String] = [
                    ParameterKey.item_id : "\(obj_2.item_id ?? 0)",
                    ParameterKey.quantity : "\(obj_2.quantity ?? 0)"
                ]
                items.append(item)
            })
            //Load Order
            let order: [String: Any] = [
                ParameterKey.delivery_date: obj.delivery_date ?? "",
                ParameterKey.items: items
            ]
            orders.append(order)
        })
        
        let params: [String: String] = [
            ParameterKey.student_id: "\(currentStudentID)",
            ParameterKey.orders: json(from: orders) ?? "",
        ]
        return params
    }

    private func json(from object:Any) -> String? {

        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}

//TableView
extension BasketVM {
    
    func numberOfSections() -> Int {
        return model?.cart_details?.count ?? 0
    }
    
    func numberOfItemsInSection(bySection section: Int) -> Int {
        return model?.cart_details?[section].items?.count ?? 0
    }
    
    func getItem(byIndexPath indexPath: IndexPath) -> BasketItem? {
        return model?.cart_details?[indexPath.section].items?[indexPath.row]
    }
    
    func getSectionItem(section: Int) -> String? {
        return model?.cart_details?[section].delivery_date
    }
}
*/
