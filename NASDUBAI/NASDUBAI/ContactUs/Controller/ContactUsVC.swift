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

class ContactUsVC:  UIViewController, CLLocationManagerDelegate{

    var contactUsModel = ContactUsModel()
    var isRevealedAdded: Bool = false
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    
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
                //self.tableView.reloadData()
            }
        }
    }

    

}
extension ContactUsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactUsModel.contentArray.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellOne = tableView.dequeueReusableCell(withIdentifier: "ContactUsFstCell", for: indexPath) as! ContactUsFstCell
            cellOne.element = contactUsModel.descriptionString
            cellOne.selectionStyle = .none
            return cellOne

        } else {
            let cellTwo = tableView.dequeueReusableCell(withIdentifier: "ContactUsSndCell", for: indexPath) as! ContactUsSndCell
            cellTwo.element = contactUsModel.contentArray[indexPath.row - 1]
            cellTwo.selectionStyle = .none
            cellTwo.emailBtn.tag = indexPath.row - 1
            cellTwo.emailBtn.addTarget(self, action: #selector(sendEmail(_:)), for: .touchUpInside)
            return cellTwo
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    @objc func sendEmail(_ sender: UIButton) {
            if MFMailComposeViewController.canSendMail() {
                let emailPicker = MFMailComposeViewController()
                emailPicker.mailComposeDelegate = self
                emailPicker.modalPresentationStyle = .fullScreen
                emailPicker.modalTransitionStyle = .coverVertical
                emailPicker.setToRecipients([contactUsModel.contentArray[sender.tag].email!])
                emailPicker.setSubject("")
                emailPicker.setMessageBody("", isHTML: true)
                emailPicker.navigationBar.barStyle = .black
                present(emailPicker, animated: true, completion: nil)
            } else {
                presentSingleBtnAlert(message: "Please configure email on device to use this feature.")
            }
        }
}

extension ContactUsVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}


extension ContactUsVC: ContactUsDelegate {
    func updateMap(region: MKCoordinateRegion, annotation: MKPointAnnotation) {
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }
}
