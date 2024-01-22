//
//  ContactUsModel.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 18/01/24.
//


import Foundation
import MapKit

protocol ContactUsDelegate {
    func updateMap(region: MKCoordinateRegion, annotation: MKPointAnnotation)
}
class ContactUsModel {

    var delegate:ContactUsDelegate?
    var descriptionString = ""
    var contentArray: [Contact] = []

    var address = "Nord Anglia International School Abu Dhabi"
    var coordinates = CLLocationCoordinate2DMake(24.3705, 54.5639)
    var deviceLocation: CLLocationCoordinate2D?

    func addLocation() {
        let annotation = MKPointAnnotation()
        annotation.title = address
        annotation.coordinate = coordinates
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: 200, longitudinalMeters: 200)
        delegate?.updateMap(region: regionSpan, annotation: annotation)
    }
    func viewLocation() {
        address = address.replacingOccurrences(of: " ", with: "+")
        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) || UIApplication.shared.canOpenURL(URL(string: "comgooglemaps-x-callback://")!) {
            let googleUrlStr = "comgooglemaps-x-callback://?saddr=\(address)&x-success=OpenInGoogleMapsSample%3A%2F%2F&x-source=OpenInGoogleMapsSample"
            UIApplication.shared.open(URL(string: googleUrlStr)!, options: [:], completionHandler: nil)
        } else {
            alertMessage.value = "Install latest version of google maps and try again."

        }

    }

    func processData(data: ContactUs?) -> (ContactUs?, APIError?) {
        if data?.status == 101 || data?.status == 102 {
            alertMessage.value = K.someErrorOccured
            return (nil, .requestFailed)
        } else if data?.status == 116 {
            return (nil, .tokenExpired)
        } else {
            return (data, nil)
        }
    }
}





struct ContactUs: Codable {
    var responseArray: ContactUsArray?
    var status: Int?
}

// MARK: - ResponseArray
struct ContactUsArray: Codable {
    var latitude, responseArrayDescription, longitude: String?
    var contacts: [Contact]?

    enum CodingKeys: String, CodingKey {
        case latitude
        case responseArrayDescription = "description"
        case longitude, contacts
    }
}

// MARK: - Contact
struct Contact: Codable {
    var phone, email, name: String?
}

