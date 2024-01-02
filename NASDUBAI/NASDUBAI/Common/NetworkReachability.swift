//
//  NetworkReachability.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 30/12/23.
//

import Foundation
import Alamofire

class NetworkManager{

    //shared instance
    static let shared = NetworkManager()

    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")

    func startNetworkReachabilityObserver() {
        self.reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                print("The network is not reachable")
            case .unknown :
                print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
            case .reachable(.cellular):
                print("The network is reachable over the WWAN connection")
            }
        }
    }
}

