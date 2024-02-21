//
//  NotificationVC.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 31/01/24.
//

import UIKit
import Alamofire

class NotificationVC: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    var start = 0
    var limit = 15
    var fetchedAllData = false
    let messageModel = MessageModel()
    var dataArray: [NotificationModel] = [] {
        didSet {
            if dataArray.isEmpty {
                return alertMessage.value = K.noNewMessages
            }
            tableView.reloadData()
        }
    }
    var isRevealedAdded : Bool = false


    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
        getMessages()
        showAlerts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !isRevealedAdded {
            self.isRevealedAdded = true
            self.addRevealToSelf()
        }
    }
    func getMessages() {
        if !ApiServices.checkReachability() 
        {
            return
        }
        let url = URL_NOTIFICATION
        let parameters: Parameters = ["page_from": "0", "scroll_to": "new"]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            let (val, err) = messageModel.processData(data: CF.processResponse(response, decodingType: Message.self))
            if let e = err {
                if e == .tokenExpired {
                    ApiServices().getAccessToken 
                    {
                        self.getMessages()
                    }
                }
            } else if let v = val {
                UIApplication.topMostViewController?.view.stopActivityIndicator()
                fetchedAllData = v.response?.data?.count ?? 0 < limit
                dataArray.append(contentsOf: v.response?.data ?? [])
                
                //Here we are reseting the appBadge count
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
        }
    }

}


extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.element = dataArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataArray.count - 1 {
            if fetchedAllData { return }
            start += 15
            getMessages()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // pushToHTML(fromMessage: true, data: dataArray[indexPath.row])
    }
}
