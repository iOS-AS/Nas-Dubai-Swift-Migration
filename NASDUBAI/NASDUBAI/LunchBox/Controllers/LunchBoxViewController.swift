//
//  LunchBoxViewController.swift
//  BISAD
//
//  Created by MOB-IOS-05 on 16/02/23.
//

import UIKit
import SDWebImage

class LunchBoxViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var emailImgView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var descriptionTopConstaint: NSLayoutConstraint!
    var contanctEmailString = ""
    var walletTopupLimit: Double = 0.0
    var imageURLString = ""
    var trnNo : String = ""
    var isRevealedAdded : Bool = false
    //0
    //32
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = ""
        setUpUI()
        self.getCanteenBannerData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !isRevealedAdded {
            self.isRevealedAdded = true
            self.addRevealToSelf()
        }
    }
    
    func setUpUI() {

        if contanctEmailString != "" {
            self.descriptionTopConstaint.constant = 31
            self.emailBtn.alpha = 1
            self.emailImgView.alpha = 1
        }else {
            self.descriptionTopConstaint.constant = 0
            self.emailBtn.alpha = 0
            self.emailImgView.alpha = 0
        }
        bannerImageView.sd_setImage(with: URL(string: imageURLString), placeholderImage: #imageLiteral(resourceName: "homePageSampleBanner.png"))
    }
}

//MARK: - Action
extension LunchBoxViewController {
    @IBAction func settingsPressed(_ sender: UIButton) {
        pushToSettings()
    }
    
    
    @IBAction func revealBtnPressed(_ sender: Any) {
        showReveal()
    }
    
    
    @IBAction func homeBtnPressed(_ sender: UIButton) {
        pushToHome()
    }
    
    @IBAction func preOrderButtnAction(_ sender: Any) {
//        let storyboardLunchBox = UIStoryboard(name: "LunchBoxStoryBoard", bundle: nil)
//        let  vc = storyboardLunchBox.instantiateViewController(withIdentifier: "PreOrderVC") as! PreOrderVC
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func informationAction(_ sender: Any) {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "InformationListVC") as! InformationListVC
//        vc.pageFrom = .canteen
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func paymentButtnAction(_ sender: Any) {
//        let storyboardLunchBox = UIStoryboard(name: "LunchBoxStoryBoard", bundle: nil)
//        let  vc = storyboardLunchBox.instantiateViewController(withIdentifier: "WalletVC") as! WalletVC
//        vc.walletTopupLimit = self.walletTopupLimit
//        vc.trnNo = self.trnNo
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func emailBtnAction(_ sender: Any) {
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "EmailPopUpViewController") as! EmailPopUpViewController
//        vc.flagValue = "FromPayment"
//        vc.emailID = self.contanctEmailString
//        vc.modalPresentationStyle = .overCurrentContext
//        present(vc, animated: false)
    }
}

//MARK: - API Call
extension LunchBoxViewController {
    func getCanteenBannerData() {
        ApiServices().getCanteenBannerData() { responseData in
            DispatchQueue.main.async {
                self.descriptionLabel.text = responseData.responseArray?.data?.description ?? ""
                self.contanctEmailString = responseData.responseArray?.data?.contactEmail ?? ""
                if let walltetAmtString = responseData.responseArray?.data?.wallet_topup_limit, let walletDouble = Double(walltetAmtString) {
                    self.walletTopupLimit = walletDouble
                }
                self.imageURLString = responseData.responseArray?.data?.image?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                self.trnNo = responseData.responseArray?.data?.trn_no ?? ""
                self.setUpUI()
            }
        }
    }
}
