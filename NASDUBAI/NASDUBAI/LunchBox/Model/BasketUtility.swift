//
//  BasketUtility.swift
//  NAS
//
//  Created by Naveeth's on 30/07/21.
//

import Foundation
//import RealmSwift
/*
protocol RLBaseDataUtility {
    associatedtype Model
    func saveData(data: Model)
    func loadData()
    func reset()
}

final class BasketUtility: RLBaseDataUtility {
    
    static let sharedInstance: BasketUtility = BasketUtility()
    var lunchBoxData: RLBasketData?
    
    func saveData(data: RLBasketData){
        
        reset()
        lunchBoxData = data
        onMainThread {
            let realm = try! Realm()
            try! realm.write({
                realm.add(data, update: .modified)
            })
        }
    }
    
    func loadData() {
        
        reset()
        
        guard let data = try? Realm().objects(RLBasketData.self).filter("primaryKey = %@", RealmKeys.basketDataKey).first else { return }
        self.lunchBoxData = data
    }
    
    func reset() {
        lunchBoxData = nil
    }
    
    //Custom Methods
    private func getRealmCardItems() -> Results<RLBasketItem>? {
        
        guard let realm = try? Realm() else { return nil }
        return realm.objects(RLBasketItem.self)
    }
    
    private func getBasketItems(byStudentID id: Int?) -> [RLBasketItem] {
        
        guard let items = getRealmCardItems() else { return [] }
        guard let studID = id else { return Array(items) }
        let selectedStudentData = Array(items).filter( { $0.id == studID })
        return selectedStudentData
    }
    
    func numberOfQuantityInBasket() -> Int {
        
        let count = getBasketItems(byStudentID: nil).reduce(0) { partialResult, cardItem in
            return partialResult + cardItem.quantity
        }
        return count
    }
    
    func getBasketTotalAmount() -> Double {
        
        let count = getBasketItems(byStudentID: nil).reduce(0) { partialResult, cardItem in
            return partialResult + (Double(cardItem.quantity) * cardItem.priceInDouble)
        }
        return count
    }
    
    func deleteBasketItem(byStudentID stud_id: Int, byFoodModel model: FoodModel) -> (Bool, String) {
        
        guard let item = getRealmCardItems()?.filter("item_id = %@ && student_id = %@", (model.id ?? 0), stud_id ).first else {
            return (false, ErrorValue.deleteItemNotFound)
        }
        guard let realm = try? Realm() else {
            return (false, ErrorValue.realmDBError)
        }
        try? realm.write {
            realm.delete(item)
        }
        printText("SUCCESS: FoodItem - \(model.id ?? 0) is removed from realm")
        return (true, ErrorValue.cardItemDeleteSuccess)
    }
    
    func addItemToBasket(byDate date: String, byCardItem item: FoodModel) {
        
        let arrayOfItems: [[String: Any]] = [item.toJSON()]
        
        let dict: [String: Any] = [
            "delivery_date": date,
            "items": arrayOfItems
        ]
        let card = RLBasketCard(value: dict)
        card.addItem()
        printText("SUCCESS: FoodItem - \(item.id ?? 0)  is Added to realm")
    }
}

class RLBasketData: Object {
    
    @objc dynamic var primaryKey = RealmKeys.basketDataKey
    //    @objc dynamic var cart_total : Double = 0.0
    //    @objc dynamic var previous_orders_total : Double = 0.0
    //    @objc dynamic var total_items_in_cart : Int = 0
    var cart_details = List<RLBasketCard>()
    
    override class func primaryKey() -> String? {
        return "primaryKey"
    }
}

class RLBasketCard: Object {
    
    @objc dynamic var delivery_date = ""
    var items = List<RLBasketItem>()
    
    override class func primaryKey() -> String? {
        return "delivery_date"
    }
    
    func addItem() {
        guard let realm = try? Realm() else { return }
        try! realm.write({
            realm.add(self, update: .modified)
        })
    }
}

class RLBasketItem: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var item_id = 0
    @objc dynamic var item_name = ""
    @objc dynamic var item_total: Double = 0
    @objc dynamic var item_description = ""
    @objc dynamic var quantity = 0
    @objc dynamic var price = ""
    @objc dynamic var priceInDouble: Double {
        return Double(self.price) ?? 0.0
    }
    @objc dynamic var student_id = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func addItem() {
        guard let realm = try? Realm() else { return }
        try! realm.write({
            realm.add(self, update: .modified)
        })
    }
}
*/
/*
class LunchCardUtility {

    static let sharedInstance: LunchCardUtility = LunchCardUtility()
    var lunchCardData: LunchCardData?

    func loadData() {

        self.lunchCardData = nil

        do {
            if let data = try Realm().objects(LunchCardData.self).filter("primaryKey = %@", RealmKeys.lunchCardDataKey).first {
                self.lunchCardData = data
            }
        } catch (let error) {
            print(error.localizedDescription)
        }
    }

    //Save
    func saveCardData(data: LunchCardData){

        self.lunchCardData = data

        onMainThread {
            let realm = try! Realm()
            try! realm.write({
                realm.add(data, update: .modified)
            })
        }
    }

    //Reset
    func reset() {
        self.lunchCardData = nil
    }

    //MARK: Get Methods
    func getList() -> [LunchCard] {
        let arrayOfData = realmList()
        return Array(arrayOfData)
    }

    func realmList() -> Results<LunchCard> {
        let realm = try! Realm()
        return realm.objects(LunchCard.self)
    }
}

class LunchCardData: Object {

    @objc dynamic var primaryKey = RealmKeys.lunchCardDataKey
    @objc dynamic var quantity = 0
    @objc dynamic var price: Double = 0

    var data = List<LunchCard>()

    override class func primaryKey() -> String? {
        return "primaryKey"
    }

    func updateValue(_ totalQuantity: Int, _ totalAmount: Double) {

        let realm = try! Realm()
        try! realm.write({
            price = totalAmount
            quantity = totalQuantity
        })
    }

    func updateQuantityPrice(_ typeOfAction: TypeOfAction?, _ itemPrice: Double) {

        if typeOfAction == .add {

            let realm = try! Realm()
            try! realm.write({
                price += itemPrice
                quantity += 1
            })

        } else if typeOfAction == .remove {

            let realm = try! Realm()
            try! realm.write({
                price -= itemPrice
                quantity -= 1
            })
        }

        print("LunchBox Data => \(price) * \(quantity) ")
    }

    //Remove
    func resetAllValues() {
        let realm = try! Realm()
        try! realm.write({
            quantity = 0
            price = 0
            data.map( { $0.removeEvent() })
        })
    }

    //Remove
    func removeData() {
        let realm = try! Realm()
        try! realm.write({
            realm.delete(self)
        })
    }
}

class LunchCard: Object {

    @objc dynamic var student_id = 0
    @objc dynamic var category_id = 0
    @objc dynamic var product_item_id = 0
    @objc dynamic var quantity = 0
    @objc dynamic var price: Double = 0


    override class func primaryKey() -> String? {
        return "student_id"
    }

    //Adding
    static func add(cards: [LunchCard]) {
        let realm = try! Realm()
        try! realm.write({
            realm.add(cards, update: .modified)
        })
    }

    //Remove
    func removeEvent() {
        let realm = try! Realm()
        try! realm.write({
            realm.delete(self)
        })
    }
}
*/
