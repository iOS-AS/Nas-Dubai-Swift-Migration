//
//  RevealVC+Extension.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 23/01/24.
//

import UIKit
var currentVC = "Home"
extension RevealViewCV {
    func gotoVC(index: Int) {
        if !DefaultsWrapper().getLoginStatus() {
            if !CF.isGuestAllowedPage(name: revealArray[index]) {
                return presentSingleBtnAlert(message: K.regUserAlertMessage)
            } else {
                pushToVC(name: revealArray[index])
            }
        } else {
            pushToVC(name: revealArray[index])
        }
    }
}


extension RevealViewCV: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return revealArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RevealCell", for: indexPath) as! RevealCell
        cell.selectionStyle = .none
        cell.element = revealArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoVC(index: indexPath.row)
    }
}


