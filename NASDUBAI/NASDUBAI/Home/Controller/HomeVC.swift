//
//  HomeVC.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 27/12/23.
//

import UIKit
import CoreData
import Alamofire
import SDWebImage
import SwiftyJSON


var firstTime = true

class HomeVC: UIViewController {

    static var alertShown: Bool = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var scrollImageView: UIImageView!
    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    func showAlert() {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let nextVc = storyBoard.instantiateViewController(withIdentifier: "Advertisement")as! Advertisement
//        nextVc.modalTransitionStyle = .crossDissolve
//        nextVc.modalPresentationStyle = .overFullScreen
//        nextVc.closeButtonCallBack = { [weak self] in
//            self?.makeNetworkCallForHomeSurveys()
//        }
//        self.present(nextVc, animated: true)
    }
    let imgArray = ["otherModulesSampleBanner", "otherModulesSampleBanner"]
    var index = 0
    let draggableView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    var draggableLbl = UILabel()
    var draggableImageView = UIImageView()

    var tileGuestArray = [GuestTiles]()
    var tileUserArray = [UserTiles]()
    var loginModel = LoginModel()
    var homeModel = HomeModel()
    var banner: Banner?
    var timerBanner: Timer?
    var currentSurveyStartedIndex: Int?
    
    private var sideMenuViewController: RevealViewCV!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    var reEnrollmentCount = 0

    // Expand/Collapse the side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!

    private var revealSideMenuOnTop: Bool = true

    var gestureEnabled: Bool = true

//    var homeSurveyDataArray: [DataArray]  = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
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
extension HomeVC{
    func setup() {
        if DefaultsWrapper().getLoginStatus() {
            if firstTime {
                loginModel.getStudentList {
                    firstTime = true
                }
            }
        }
        homeModel.getBanners { [self] (completed) in
            banner = completed
            if let notice = banner?.responseArray?.notice, notice != "" {
                if !HomeVC.alertShown {
                    showAlert()
                    HomeVC.alertShown = true
                }
            }
            if  banner?.responseArray?.enrollment_status == 1 {
                if reEnrollmentCount == 1 {
                    let keyVal = UserDefaults.standard.object(forKey: "ReEnrollmntKey") as? String
                    if keyVal == "true"{
//                        showReEnrollmentAlert()
                        UserDefaults.standard.set("false", forKey: "ReEnrollmntKey")
                    }
                } else { }
            }
            setSlider()
        }
//        tileLbls.forEach { $0.dropShadow() }
        addRevealToSelf(self)
        getTilesData()
        showAlerts()

        homeModel.updateApp = {
            self.presentUpdatePopupVC()
        }
    }
}
