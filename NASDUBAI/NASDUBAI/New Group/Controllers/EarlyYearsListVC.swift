//
//  EarlyYearsListVC.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 18/01/24.
//

import UIKit

class EarlyYearsListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleView: UILabel!
    @objc var titleString: String = "Coming Up"
    var dataArray: [EarlyListValueFile] = []
    @objc var dataArrayDict: [[String: Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        if dataArrayDict.count > 0 {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dataArrayDict, options: .prettyPrinted)
                dataArray = try JSONDecoder().decode([EarlyListValueFile].self, from: jsonData)
            }catch { }
        }
        self.titleView.text = titleString
        self.tableView.reloadData()
    }
}

extension EarlyYearsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var cell: UITableViewCell?
        var cellBgVIew: UIView?
        var titleLabel: UILabel?

        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            
            cellBgVIew = UIView(frame: CGRect(x: 10, y: 0, width: tableView.frame.size.width-20, height: 40))
            cellBgVIew!.backgroundColor = .white
            
            let smallPortionVIew = UIView(frame: CGRect(x: 5, y: 2, width: 5, height: 40))
            smallPortionVIew.backgroundColor = UIColor(red: 077.0/255, green:196.0/255.0, blue:207.0/255.0, alpha:1.0)
            
            let separatorVIew = UIView(frame: CGRect(x: 10, y: 39, width: tableView.frame.size.width-20, height: 1))
            separatorVIew.backgroundColor = UIColor(red: 077.0/255, green:196.0/255.0, blue:207.0/255.0, alpha:1.0)
            
            var disclosureArrow = UIImageView(frame: CGRect(x: cellBgVIew!.bounds.size.width-20, y: 10, width: 20, height: 20))
            disclosureArrow.image = UIImage(named: "rightarrow")
            disclosureArrow.backgroundColor = .clear
            
            titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: cellBgVIew!.bounds.size.width-35, height: 40))
            titleLabel!.font = UIFont(name: "SourceSansPro-Regular", size: 14) ?? .systemFont(ofSize: 14)
            titleLabel!.backgroundColor = .clear
            titleLabel!.textColor = .black
            if self.titleString == "Accreditations & Examinations" {
                cellBgVIew = UIView(frame: CGRect(x: 5, y: 2, width: tableView.frame.size.width-10, height: 40))
                cellBgVIew!.backgroundColor = UIColor(red: 0.0/255, green:45.0/255.0, blue:74.0/255.0, alpha:1.0)
                
                disclosureArrow = UIImageView(frame: CGRect(x: cellBgVIew!.bounds.size.width-25, y: 10, width: 20, height: 20))
                disclosureArrow.image = UIImage(named: "arrow_list")
                disclosureArrow.backgroundColor = .clear
                
                titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: cellBgVIew!.bounds.size.width-45, height: 40))
                titleLabel!.font = UIFont(name: "SourceSansPro-Regular", size: 14) ?? .systemFont(ofSize: 14)
                titleLabel!.backgroundColor = .clear
                titleLabel!.textColor = .white

            }
            cell?.contentView.addSubview(cellBgVIew!)
            if self.titleString == "Accreditations & Examinations" {
                cell?.contentView.addSubview(smallPortionVIew)
            }else {
                cell?.contentView.addSubview(separatorVIew)
            }
            cellBgVIew!.addSubview(disclosureArrow)
            cellBgVIew!.addSubview(titleLabel!)
            
        }
        let objData = self.dataArray[indexPath.row]
        titleLabel?.text = objData.title ?? ""
        
        cell?.selectionStyle = .none
        cell?.backgroundColor = .white
        cell?.clipsToBounds = true
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboardMain.instantiateViewController(withIdentifier: "CommonWebViewController") as! CommonWebViewController
//        vc.url = self.dataArray[indexPath.row].image ?? ""
//        vc.fromSocialMedia = false
//        vc.titleStr = "Coming Up"
//        vc.isTermsService = false
//        navigationController?.pushViewController(vc, animated: true)
    }
}

