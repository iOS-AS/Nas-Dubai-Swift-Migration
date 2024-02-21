//
//  CommonWebView.swift
//  NASDUBAI
//
//  Created by MOB-IOS-05 on 22/01/24.
//

import UIKit
import WebKit
import Alamofire

class CommonWebView: UIViewController {
    
    @IBOutlet weak var titleViewHgt: NSLayoutConstraint!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var titleView: UILabel!
    var url: String = ""
    var titleStr = ""
    var fromSocialMedia = false
    var isTermsService = false

    var commonWebModel = CommonWebModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.text = titleStr
        if fromSocialMedia {
            titleViewHgt.constant = 0
        }
        webView.navigationDelegate = self
        UIApplication.topMostViewController?.view.startActivityIndicator()

        if isTermsService {
            getData()
        } else {
            if let URL = URL(string: url) {
                webView.load(URLRequest(url: URL))
            }
        }
    }

    func getData() {
        if !ApiServices().checkReachability() {
            return
        }
        let url = BASE_URL + "terms_of_service"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(DefaultsWrapper().getAccessToken())"]
        UIApplication.topMostViewController?.view.startActivityIndicator()
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { [self] (response) in
            let (val, err) = commonWebModel.processData(data: CF.processResponse(response, decodingType: TermsService.self))
            if let e = err {
                if e == .tokenExpired {
                    ApiServices().getAccessToken {
                        getData()
                    }
                }
            } else if let v = val {
                UIApplication.topMostViewController?.view.stopActivityIndicator()
                webView.loadHTMLString(commonWebModel.setWebViewWithData(data: v.responseArray?.termsOfService), baseURL: nil)

            }
        }
    }

    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeBtn(_ sender: Any) {
        pushToHome()
    }
    
}
extension CommonWebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.topMostViewController?.view.stopActivityIndicator()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIApplication.topMostViewController?.view.stopActivityIndicator()
    }
}
