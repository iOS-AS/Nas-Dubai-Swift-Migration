//
//  OrderHistoryVM.swift
//  NAS
//
//  Created by Naveeth's on 01/06/21.
//

import UIKit
/*
class OrderHistoryVM: BaseVM2 {
    
    var arrayOfItems: [CanteenOrdersHistory] = []
    
    init(studID: Int?) {
        super.init()
        self.currentStudentID = studID ?? 0
    }
    
    func initializeData() {
        
    }
    
    func callOrderHistoryAPI(completion: @escaping DisplayHandler) {
        
        LunchBoxResource2().getOrderHistoryList(student_id: currentStudentID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let val):
                self.arrayOfItems = val
                completion(true, nil)
                break
            case .failure(let err):
                completion(false, err.localizedDescription)
                break
            }
        }
    }
    
    func getDateTitle(section: Int) -> NSMutableAttributedString? {
        
        guard let date = getSectionItem(section: section)?.getExpectedFormatDateFromString(currentFomat: DateFormatterType.yyyy_MM_dd, expectedFromat: DateFormatterType.dd_MMM_yyyy) else { return nil }
        
        let day = date.day
        let monthYear = date.month + " " + date.year
        
        let dayAttributeFont = AppVariable.shared.appFontWithSize(type: .Semibold, size: 6.0)
        let monthYearAttribute1Font = AppVariable.shared.appFontWithSize(type: .Regular, size: 4.0)
        
        let dayAttribute = [NSAttributedString.Key.font: dayAttributeFont as Any, NSAttributedString.Key.foregroundColor: UIColor.black as Any]
        let monthYearAttribute = [NSAttributedString.Key.font: monthYearAttribute1Font as Any, NSAttributedString.Key.foregroundColor: UIColor.black as Any]
        
        let dayString = NSMutableAttributedString(string: day, attributes: dayAttribute)
        let monthYearString = NSMutableAttributedString(string: monthYear, attributes: monthYearAttribute)
        
        dayString.append(NSMutableAttributedString(string: " "))
        dayString.append(monthYearString)
        return dayString
    }
}

//TableView
extension OrderHistoryVM: VMTableViewMethods {
    
    typealias Model = CanteenOrderedItems
    
    func numberOfSections() -> Int {
        return arrayOfItems.count
    }
    
    func numberOfItemsInSection(bySection section: Int) -> Int {
        return arrayOfItems[section].canteen_preordered_items?.count ?? 0
    }
    
    func getItem(byIndexPath indexPath: IndexPath) -> CanteenOrderedItems? {
        return arrayOfItems[indexPath.section].canteen_preordered_items?[indexPath.row]
    }
    
    func getSectionItem(section: Int) -> String? {
        
        //        guard let item = arrayOfItems[section].delivery_date?.getFormattedDate(currentFomat: DateFormatterType.yyyy_MM_dd, expectedFromat: DateFormatterType.dd_MMM_yyyy) else { return nil }
        //        print(item)
        return arrayOfItems[section].delivery_date
    }
}
*/
