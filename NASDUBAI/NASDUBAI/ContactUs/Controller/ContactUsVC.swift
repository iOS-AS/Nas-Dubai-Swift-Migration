//
//  ContactUsVC.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 18/01/24.
//

import UIKit
import MapKit
import MessageUI
import Alamofire
import SwiftyJSON

class ContactUsVC:  UIViewController, CLLocationManagerDelegate  {

    var contactUsModel = ContactUsModel()
    var isRevealedAdded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactUsModel.delegate = self
        getData()
        print("Func called")
        showAlerts()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !isRevealedAdded {
            self.isRevealedAdded = true
            self.addRevealToSelf()
        }
    }

    func getData() {
        if !ApiServices.checkReachability() {
            return
        }
        let url = BASE_URL + "contact_us"
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post , encoding: JSONEncoding.default).responseJSON { [self] (response) in
            let (val, err) = contactUsModel.processData(data: CF.processResponse(response, decodingType: ContactUs.self))
            if let e = err {

            } else if let v = val {
                UIApplication.topMostViewController?.view.stopActivityIndicator()
                contactUsModel.contentArray = v.responseArray?.contacts ?? []
                contactUsModel.descriptionString = v.responseArray?.responseArrayDescription ?? ""
                contactUsModel.coordinates = CLLocationCoordinate2DMake(Double(v.responseArray?.latitude ?? "0")!, Double(v.responseArray?.longitude ?? "0")!)
                print(contactUsModel.coordinates)
                contactUsModel.addLocation()
                self.tableView.reloadData()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
