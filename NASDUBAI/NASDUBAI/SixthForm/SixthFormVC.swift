//
//  SixthFormVC.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 18/01/24.
//

import UIKit

class SixthFormVC: UIViewController {

    var contanctEmailString = ""
    var imageURLString = ""
    var dataArray: [EarlyListValueDataItem] = []
    var isRevealedAdded : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        self.tableView.separatorStyle = .none
        //self.getDepartmentPrimaryListData()
    }
    
    func setUpUI() {
//        bannerImageView.sd_setImage(with: URL(string: imageURLString), placeholderImage: #imageLiteral(resourceName: "homePageSampleBanner.png"))
//        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !isRevealedAdded {
            self.isRevealedAdded = true
            self.addRevealToSelf()
        }
    }
}
//extension SixthFormVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.dataArray.count > 0 ? self.dataArray.count + 1 : 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell: UITableViewCell?
//        var titleLabel: UILabel?
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
//
//            let cellBgVIew = UIView(frame: CGRect(x: 5, y: 2, width: tableView.frame.size.width-10, height: 40))
//            cellBgVIew.backgroundColor = UIColor(red: 0.0/255.0, green:45.0/255.0, blue:74.0/255.0, alpha:1.0)
//            cell?.contentView.addSubview(cellBgVIew)
//
//            let smallPortionVIew = UIView(frame: CGRect(x: 5, y: 2, width: 5, height: 40))
//            smallPortionVIew.backgroundColor = UIColor(red: 077.0/255, green:196.0/255.0, blue:207.0/255.0, alpha:1.0)
//            cell?.contentView.addSubview(smallPortionVIew)
//
//            let separatorVIew = UIView(frame: CGRect(x: 5, y: 40, width: tableView.frame.size.width-10, height: 4))
//            separatorVIew.backgroundColor = .white
////            cell?.contentView.addSubview(separatorVIew)
//
//            let disclosureArrow = UIImageView(frame: CGRect(x: cellBgVIew.bounds.size.width-25, y: 10, width: 20, height: 20))
//            disclosureArrow.image = UIImage(named: "arrow_list")
//            disclosureArrow.backgroundColor = .clear
//            cellBgVIew.addSubview(disclosureArrow)
//
//            titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: cellBgVIew.bounds.size.width-45, height: 40))
//            titleLabel!.font = UIFont(name: "SourceSansPro-Regular", size: 14) ?? .systemFont(ofSize: 14)
//            titleLabel!.backgroundColor = .clear
//            titleLabel!.textColor = .white
//            cellBgVIew.addSubview(titleLabel!)
//        }
//        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        if (indexPath.row == 0) {
//            titleLabel?.text = "Coming Up"
//        }else {
//            if indexPath.row - 1 < dataArray.count {
//                titleLabel?.text = dataArray[indexPath.row - 1].name ?? ""
//            }else {
//                titleLabel?.text = ""
//            }
//        }
//        cell?.selectionStyle = .none
//        cell?.backgroundColor = .clear
//        cell?.clipsToBounds = true
//        return cell!
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            let nextVc = EarlyYearsComingUpViewController(nibName: "EarlyYearsComingUpViewController", bundle: nil)
//            nextVc.isFromWholeSchool = false
//            nextVc.titleString = "Coming Up"
//            nextVc.sourcePageOfComingUp = .primary
//            navigationController?.pushViewController(nextVc, animated: true)
//        }else {
//            guard indexPath.row - 1 >= 0, self.dataArray.count > indexPath.row - 1 else { return }
//            let nextVc = PrimaryNewsListViewController(nibName: "PrimaryNewsListViewController", bundle: nil)
//            let obj = self.dataArray[indexPath.row - 1]
//            nextVc.dataArray = obj.file ?? []
//            nextVc.titleString = obj.name ?? "Primary"
//            navigationController?.pushViewController(nextVc, animated: true)
//        }
//    }
//}

//MARK: - API Call
extension SixthFormVC {
//    func getDepartmentPrimaryListData() {
//        ApiServices().getDepartmentPrimaryListFromAPI() { responseData in
//            DispatchQueue.main.async {
//                self.dataArray = responseData.responseArray?.data ?? []
//                self.imageURLString = responseData.responseArray?.bannerImage?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//                self.setUpUI()
//            }
//        }
//    }
}
