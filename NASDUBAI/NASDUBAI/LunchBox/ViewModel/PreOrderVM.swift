//
//  PreOrderVM.swift
//  NAS
//
//  Created by Naveeth Parvege on 25/05/21.
//

import UIKit

class PreOrderVM {

    var sectionItems: [CollectionItem] = []
    
    func initializeData() {
        createSectionItem()
    }
    
    func numberOfSection() -> Int {
        return sectionItems.count
    }
    
    func getSectionItem(index: Int) -> CollectionItem {
        return sectionItems[index]
    }
    
    func createSectionItem() {
        
        sectionItems.removeAll()
        
        let add_order = CollectionItemValue(badge: 0, imageName: ImageName.add_order, title: DefaultValue.addOrder, bgColor: .appThemeColor())
        sectionItems.append(CollectionItem(title: "", itemtype: ListItemType.TabType.rawValue, typeOfCell: CollectionItemCellType.SingleSquare.rawValue, values: [add_order]))

        let myOrderColor = UIColor(red: 245.0/255.0, green: 134.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        let myOrder = CollectionItemValue(badge: 0, imageName: ImageName.my_order, title: DefaultValue.myOrder, bgColor: myOrderColor)
        let orderHistory = CollectionItemValue(badge: 0, imageName: ImageName.order_history, title: DefaultValue.orderHistory, bgColor: .secondaryColor())

        sectionItems.append(CollectionItem(title: "", itemtype: ListItemType.TabType.rawValue, typeOfCell: CollectionItemCellType.DoubleSquare.rawValue, values: [myOrder, orderHistory]))
    }
    
    /*
    func callAPI(completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().getWalletDetails(student_id: currentStudentID) { [weak self] result, response, message in
            
            guard let self = self else { return }
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
    */
}

struct CollectionItem{
    let title: String
    let itemtype: String
    var typeOfCell: String
    var values: [CollectionItemValue]
}
struct CollectionItemValue {
    var badge: Int
    var badgeType: TypeOfBadgeColor? = .no_color
    var imageName: String
    var title: String
    var bgColor: UIColor
}
enum TypeOfBadgeColor {
    case no_color, new, updated
}
enum ListItemType: String {

    case Email = "Email"
    case Desc = "Desc"
    case TabType = "TabType"
}

enum CollectionItemCellType: String {
    case SingleSquare = "SingleSquare"
    case DoubleSquare = "DoubleSquare"
    case TripleSquare = "TripleSquare"
}
