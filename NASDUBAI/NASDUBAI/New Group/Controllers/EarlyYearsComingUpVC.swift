//
//  EarlyYearsComingUpVC.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 18/01/24.
//

import UIKit

class EarlyYearsComingUpVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var isFromWholeSchool: Bool = false
    var sourcePageOfComingUp: SourcePageOfComingUp = .earlyYear
    var titleString: String = "Coming Up"
    var dataArray: [EarlyComingUpValueDataItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        if isFromWholeSchool {
            self.getWholeSchoolComingUpData()
        }else {
            switch sourcePageOfComingUp {
            case .earlyYear:
                self.getEarlyComingUpData()
            case .primary:
                self.getPrimaryComingUpData()
            case .secondary:
                self.getSecondaryComingUpData()
            }
            
        }
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
    func setUpUI() {
        self.titleLabel.text = titleString
        self.tableView.reloadData()
    }
}
extension EarlyYearsComingUpVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        var cellBgVIew: UIView?
        var titleLabel: UILabel?
        var timeLabel: UILabel?
        var colorLabel: UILabel?
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            
            cellBgVIew = UIView(frame: CGRect(x: 10, y: 0, width: tableView.frame.size.width-20, height: 50))
            cellBgVIew!.backgroundColor = .white
            cell?.contentView.addSubview(cellBgVIew!)
            
//            let smallPortionVIew = UIView(frame: CGRectMake(5, 2, 5, 50))
//            smallPortionVIew.backgroundColor = UIColor(red: 077.0/255, green:196.0/255.0, blue:207.0/255.0, alpha:1.0)
//            cell?.contentView.addSubview(smallPortionVIew)
            
            let separatorVIew = UIView(frame: CGRect(x: 10, y: 49, width: tableView.frame.size.width-20, height: 1))
            separatorVIew.backgroundColor = UIColor(red: 077.0/255, green:196.0/255.0, blue:207.0/255.0, alpha:1.0)
            cell?.contentView.addSubview(separatorVIew)
            
            let disclosureArrow = UIImageView(frame: CGRect(x: cellBgVIew!.bounds.size.width-20, y: 15,width:  20,height: 20))
            disclosureArrow.image = UIImage(named: "rightarrow")
            disclosureArrow.backgroundColor = .clear
            cellBgVIew!.addSubview(disclosureArrow)
            
            titleLabel = UILabel(frame: CGRect(x: 0,y: 5, width: cellBgVIew!.bounds.size.width-80,height: 25))
            titleLabel!.font = UIFont(name: "SourceSansPro-Regular", size: 14) ?? .systemFont(ofSize: 14)
            titleLabel!.numberOfLines = 1
            titleLabel!.backgroundColor = .clear
            titleLabel!.textColor = .black
            cellBgVIew!.addSubview(titleLabel!)
            
            timeLabel = UILabel(frame: CGRect(x: 0, y: 30, width: cellBgVIew!.bounds.size.width-35,height: 15))
            timeLabel!.font = UIFont(name: "SourceSansPro-Regular", size: 11) ?? .systemFont(ofSize: 11)
            timeLabel!.numberOfLines = 1
            timeLabel!.backgroundColor = .clear
            timeLabel!.textColor = .lightGray
            cellBgVIew!.addSubview(timeLabel!)
            
            colorLabel = UILabel(frame: CGRect(x: cellBgVIew!.bounds.size.width-75, y: 15, width: 50, height: 20))
            colorLabel!.font = UIFont(name: "SourceSansPro-Regular", size: 11) ?? .systemFont(ofSize: 11)
            colorLabel!.numberOfLines = 1
            colorLabel!.backgroundColor = .red
            colorLabel!.textColor = .white
            colorLabel!.textAlignment = .center
            colorLabel!.layer.cornerRadius = 6
            colorLabel!.clipsToBounds = true
            if self.isFromWholeSchool {
                cellBgVIew!.addSubview(colorLabel!)
            }
        }
        let objData = self.dataArray[indexPath.row]
        titleLabel?.text = objData.title ?? ""
        timeLabel?.text = objData.dateString?.getFormattedDateForUS(currentFomat: DateFormatterType.yyyy_MM_dd, expectedFromat: DateFormatterType.dd_MMM_yyyy) ?? ""
        if self.isFromWholeSchool {
            colorLabel?.text = "--"
            if let status = objData.status {
                if status == "0" {
                    colorLabel?.text = "New"
                    colorLabel?.layer.cornerRadius = 4
                    colorLabel?.clipsToBounds = true
                    colorLabel?.frame = CGRect(x: cellBgVIew!.bounds.size.width-55, y: 17.5, width: 30,height: 15)
                    colorLabel?.backgroundColor = UIColor(red: 238.0/255, green:41.0/255.0, blue:83.0/255.0, alpha:1.0)
                }else if status == "2" {
                    colorLabel?.text = "Updated"
                    colorLabel?.layer.cornerRadius = 6
                    colorLabel?.clipsToBounds = true
                    colorLabel?.frame = CGRect(x: cellBgVIew!.bounds.size.width-75, y: 15, width: 50, height: 20)
                    colorLabel?.backgroundColor = UIColor(red: 0.0/255, green:45.0/255.0, blue:74.0/255.0, alpha:1.0)
                }else {
                    colorLabel?.alpha = 0
                }
            }
        }
        
        cell?.selectionStyle = .none
        cell?.backgroundColor = .white
        cell?.clipsToBounds = true
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.isFromWholeSchool {
            let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboardMain.instantiateViewController(withIdentifier: "CommonWebView") as! CommonWebView
            vc.url = self.dataArray[indexPath.row].image ?? ""
            vc.fromSocialMedia = false
            vc.titleStr = "Coming Up"
            vc.isTermsService = false
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - API Call
extension EarlyYearsComingUpVC {
    func getWholeSchoolComingUpData() {
        ApiServices().getWholeSchoolComingUpFromAPI() { responseData in
            DispatchQueue.main.async {
//                self.dataArray = responseData.responseArray?.data ?? []
                self.setUpUI()
            }
        }
    }
    
    func getEarlyComingUpData() {
        ApiServices().getEarlyComingUpFromAPI() { responseData in
            DispatchQueue.main.async {
                self.dataArray = responseData.responseArray?.data ?? []
                self.setUpUI()
            }
        }
    }
    
    func getPrimaryComingUpData() {
        ApiServices().getPrimaryComingUpFromAPI() { responseData in
            DispatchQueue.main.async {
                self.dataArray = responseData.responseArray?.data ?? []
                self.setUpUI()
            }
        }
    }
    
    func getSecondaryComingUpData() {
        ApiServices().getSecondaryComingUpFromAPI() { responseData in
            DispatchQueue.main.async {
                self.dataArray = responseData.responseArray?.data ?? []
                self.setUpUI()
            }
        }
    }
}

enum SourcePageOfComingUp {
    case earlyYear, primary, secondary
}

