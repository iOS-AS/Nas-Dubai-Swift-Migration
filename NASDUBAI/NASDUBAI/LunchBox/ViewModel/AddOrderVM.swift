//
//  AddOrderVM.swift
//  NAS
//
//  Created by Naveeth Parvege on 26/05/21.
//

import UIKit
import ObjectMapper
/*
class AddOrderVM: BaseVM2 {
    
    //Category Item
    var categoryModel: ListModel?
    var selectedCategoryIndex: Int = 0
    
    //Current Student
    //    var studentId : Int?
    var arrayOfCalendar: [CalendarViewData]?
    
    //Item
    var arrayOfFoodItems: [FoodModel] = []
    
    init(studID: Int?, arrayOfCal: [CalendarViewData]?) {
        super.init()
        
        self.currentStudentID = studID ?? 0
        //Handling CalendarData
        self.arrayOfCalendar = arrayOfCal?.sorted(by: { $0.date.compare($1.date) == .orderedAscending })
        if arrayOfCalendar?.first?.date.isToday ?? false {
            arrayOfCalendar?.removeFirst()
        }
    }
    
    func initializeData() {
        //Initialize we are setting the first index as SELECTED
        arrayOfCalendar?.first?.isSelected = true
    }
    
    //Date
    func updateSelectedDate(item: CalendarViewData) {
        
        let _ = arrayOfCalendar?.map({ obj in
            if obj.id == item.id {
                obj.isSelected = true
            } else {
                obj.isSelected = false
            }
        })
    }
    
    func isSelectedSameDate(byItem item: CalendarViewData) -> Bool {
        
        guard let alreadySelectedData = arrayOfCalendar?.filter( { $0.isSelected }).first else {
            return false
        }
        return alreadySelectedData.id == item.id
    }
    
    func getChoosedDate() -> String {
        
        guard let index = arrayOfCalendar?.firstIndex(where:  { $0.isSelected == true }) else { return "" }
        return arrayOfCalendar?[index].date.getStringFromDate(format: DateFormatterType.yyyy_MM_dd) ?? ""
    }
    
    //MARK:- CardList
    func callGetCardItemAPI(completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().getCardItem(student_id: currentStudentID) { result, response, message in
            
            switch result {
            case .success(_):
                //                let model = response as? CanteenCard
                //Update To Realm LunchBoxData
                //                LunchCardUtility.sharedInstance.lunchCardData?.updateValue(model?.total_items_in_cart ?? 0, model?.cart_totoal ?? 0.0)
                completion(true, message)
                break
            case .failure(_):
                completion(false, message)
                break
            }
        }
    }
    
    //MARK:- Category
    func numberOfCategoryItems() -> Int {
        return categoryModel?.sub_menus?.count ?? 0
    }
    
    func getCategoryItem(index: Int) -> SubMenus? {
        return categoryModel?.sub_menus?[index]
    }
    
    func isSameCategorySelected(byIndex index: Int) -> Bool {
        return selectedCategoryIndex == index
    }
    
    func updateSelectedCategory(index: Int) {
        selectedCategoryIndex = index
        //Reset pagination data before start CategoryApi call
        setPullToRefreshData()
    }
    
    func setPullToRefreshData() {
        isPaginating = false
        start = 1
        isUptoDate = false
        isPullToRefresh = true
    }
    
    func isSelectedCategory(index: Int) -> Bool {
        if selectedCategoryIndex == index {
            return true
        }
        return false
    }
    
    //Get Category List
    func callCategoryAPI(completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().getItemCategories { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let val):
                self.categoryModel = val
                completion(true, "")
                break
            case .failure(let err):
                completion(false, err.message)
                break
            }
        }
    }
    
    //MARK:- Product List
    func resetArrayOfFoodItems() {
        arrayOfFoodItems = []
    }
    
    func numberOfItems() -> Int {
        return arrayOfFoodItems.count
    }
    
    func getItem(index: Int) -> FoodModel? {
        return arrayOfFoodItems[index]
    }
    
    func updateModel(model: FoodModel?) {
        
        guard let model = model else { return }
        
        if let index = arrayOfFoodItems.firstIndex(where: { (obj) -> Bool in
            obj.id == model.id
        }) {
            arrayOfFoodItems[index] = model
        }
    }
    
    //Get Item List
    func callItemAPI(completion: @escaping DisplayHandler) {
        
        let category_id = categoryModel?.sub_menus?[selectedCategoryIndex].id
        let date = getChoosedDate() //"2021-07-19" // "2021-05-31"
        
        LunchBoxResource2().getItemList(category_id: category_id,
                                        student_id: currentStudentID,
                                        date: date,
                                        page_number: start) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let arrayOfItems):
                if self.isPaginating {
                    self.arrayOfFoodItems.append(contentsOf: arrayOfItems)
                } else {
                    self.arrayOfFoodItems = arrayOfItems
                }
                completion(true, nil)
                break
            case .failure(let err):
                completion(false, err.message)
                break
            }
        }
    }
    
    //MARK:- AddToCart
    func updateItemCount(typeOfAction: TypeOfAction?, model: FoodModel?) {
        
        let quantity = typeOfAction == .add ? 1 : -1
        
        guard let index = arrayOfFoodItems.firstIndex(where:  { $0.id == model?.id }) else { return }
        let count = (arrayOfFoodItems[index].totalAddedQuantity ?? 0 ) + quantity
        arrayOfFoodItems[index].totalAddedQuantity = count
        /*
         //Update To Realm LunchBoxData
         if typeOfAction == .add {
         LunchBoxUtility.sharedInstance.addCard(byDate: getChoosedDate(),
         byCardItem: arrayOfFoodItems[index])
         } else if typeOfAction == .remove {
         let _ = LunchBoxUtility.sharedInstance.deleteCardItem(byStudentID: currentStudentID, byFoodModel: arrayOfFoodItems[index])
         }
         */
    }
    
    //First Time Adding to Card
    func callAddToCardAPI(model: FoodModel?, completion: @escaping DisplayHandler) {
        
        let date = getChoosedDate()
        
        LunchBoxResource2().addToCard(student_id: currentStudentID,
                                      date: date,
                                      quantity: 1,
                                      item_id: model?.id) { [weak self] result, response, message in
            
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.updateItemCount(typeOfAction: .add, model: model)
                completion(true, message)
                break
            case .failure(_):
                completion(false, message)
                break
            }
        }
    }
    
    //MARK:- UpdateItem
    func callUpdateCardItemAPI(_ typeOfAction: TypeOfAction?, model: FoodModel?, completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().updateToCard(params: makeUpdateCardItemAPIParameters(typeOfAction,
                                                                                 model: model)) { [weak self] result, response, message in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.updateItemCount(typeOfAction: .add, model: model)
                completion(true, message)
                break
            case .failure(_):
                completion(false, message)
                break
            }
        }
    }
    
    private func makeUpdateCardItemAPIParameters(_ typeOfAction: TypeOfAction?, model: FoodModel?) -> [String: Any] {
        
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
        
        //Load Items array
        var items: [[String: Any]] = []
        
        let _ = arrayOfFoodItems.map { obj in
            
            if let totalQuantity = obj.totalAddedQuantity, totalQuantity > 0 {
                
                var quant = 0
                if model?.id == obj.id {
                    quant = typeOfAction == .add ? (totalQuantity + 1) : (totalQuantity - 1)
                }
                
                let item: [String: String] = [
                    ParameterKey.item_id : "\(obj.id ?? 0)",
                    ParameterKey.quantity : "\(quant)"
                ]
                items.append(item)
            }
        }
        
        //Load Orders
        var orders: [[String: Any]] = []
        let order: [String: Any] = [
            ParameterKey.delivery_date: getChoosedDate(),
            ParameterKey.items: items
        ]
        orders.append(order)
        
        let params: [String: String] = [
            ParameterKey.student_id: "\(currentStudentID )",
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
    
    //MARK:- Remove Item
    func callRemoveCardItemAPI(typeOfAction: TypeOfAction?, item: FoodModel?, completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().removeCardItem(canteen_cart_id: item?.id) { [weak self] result, response, message in
            
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.resetCardItem(item: item)
                completion(true, message)
                break
            case .failure(_):
                completion(false, message)
                break
            }
        }
    }
    
    private func resetCardItem(item: FoodModel?) {
        
        guard let item = item else { return }
        //Reset the total price
        item.totalAddedQuantity = 0
        /*
         //Update To Realm LunchBoxData
         LunchCardUtility.sharedInstance.lunchCardData?.updateQuantityPrice(.remove,
         Double(item.price ?? 0.0 ))
         */
    }
}
*/
