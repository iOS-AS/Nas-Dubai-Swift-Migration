//
//  HomeVC+Extension.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 30/01/24.
//

import UIKit
import CoreData
import SDWebImage

//MARK:- Slider Functions

extension HomeVC {

    func setSlider() {

        if let bannerArray = banner?.responseArray?.bannerImages {
            let width = view.frame.size.width
            let height = scrollView.frame.size.height
            scrollView.frame = CGRect(x: scrollImageView.frame.origin.x, y: scrollImageView.frame.origin.y, width: width, height: height)
            for i in 0..<bannerArray.count{
                let imageView = UIImageView()
                let url = bannerArray[i]
                imageView.sd_setImage(with: URL(string: url), completed: nil)
                imageView.contentMode = .scaleToFill
                let xPosition = self.view.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPosition, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
                scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
                scrollView.addSubview(imageView)
            }
            if self.timerBanner != nil {
                self.timerBanner?.invalidate()
                self.timerBanner = nil
            }
            self.timerBanner = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(moveImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func moveImage() {
        let width = view.frame.size.width
        index += 1
        if index == banner?.responseArray?.bannerImages?.count {
            index = 0
            scrollView.contentOffset.x = 0
        } else {
            UIView.animate(withDuration: 0.5) { [self] in
                scrollView.contentOffset.x = width * CGFloat(index)
            }
        }
    }
}

//MARK:- Tiles Data
extension HomeVC {

    func getTilesData() {

        if DefaultsWrapper().getLoginStatus() {
            let fetchRequest: NSFetchRequest<UserTiles> = UserTiles.fetchRequest()
            do {
                tileUserArray = try K.context.fetch(fetchRequest)
                setTiles()
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        } else {
            let fetchRequest: NSFetchRequest<GuestTiles> = GuestTiles.fetchRequest()
            do {
                tileGuestArray = try K.context.fetch(fetchRequest)
                setTiles()
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }

    }

    func setTiles() {

        setDefaultTiles()
        if DefaultsWrapper().getLoginStatus() {

            for i in 0..<tileUserArray.count {
                if (tileUserArray.count > 0){
                    let number = Int(tileUserArray[i].number)
                    tileLbls[number].text = tileUserArray[i].name?.uppercased()
                    tileImageViews[number].image = UIImage(named: "sideBar_\(tileUserArray[i].name?.capitalized ?? "").png")
                    print(tileLbls[number].text ?? "")
                }
            }


        } else {
            for i in 0..<tileGuestArray.count {
                if (tileGuestArray.count > 0){
                    let number = Int(tileGuestArray[i].number)
                    tileLbls[number].text = tileGuestArray[i].name?.uppercased()
                    tileImageViews[number].image = UIImage(named: "sideBar_\(tileGuestArray[i].name?.capitalized ?? "").png")
                    print(tileLbls[number].text ?? "")
                }
            }
        }
    }

    fileprivate func saveToCoreData(_ i: Int) {
        if DefaultsWrapper().getLoginStatus() {
            let newTile = UserTiles(context: K.context)
            newTile.name = tileLbls[i].text
            newTile.number = Int64(i)
            do {
                try K.context.save()
            } catch {
                print(error.localizedDescription)
            }
        }else {
            let newTile = GuestTiles(context: K.context)
            newTile.name = tileLbls[i].text
            newTile.number = Int64(i)
            do {
                try K.context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func setDefaultTiles() {

        if (K.tileArray.count > 0){
            for i in 0..<K.tileArray.count {
                tileLbls[i].text = K.tileArray[i].uppercased()
                tileImageViews[i].image = UIImage(named: "sideBar_\(K.tileArray[i].capitalized).png")
            }
        }
    }
}


//MARK:- Reveal Functions

extension HomeVC: RevealDelegate {

    func createDragableCell(frame: CGRect, title: String) {

        draggableView.frame = frame
        draggableView.backgroundColor = #colorLiteral(red: 0.3519416153, green: 0.7905560732, blue: 0.8365017176, alpha: 1)
        draggableLbl = UILabel(frame: CGRect(x: 50, y: 0, width: draggableView.frame.width - 50, height: draggableView.frame.height))
        draggableLbl.text = title
        draggableView.addSubview(draggableLbl)

        draggableImageView = UIImageView(frame: CGRect(x: 5, y: draggableView.frame.height/2 - 20, width: 40, height: 40))
        draggableImageView.image = UIImage(named: "sideBar_\(draggableLbl.text?.capitalized ?? "").png")
        draggableView.addSubview(draggableImageView)

        self.view.addSubview(draggableView)
        hideReveal()
    }

    func moveDragableCell(point: CGPoint) {

        draggableView.center = point
        tileBtns.forEach { (btn) in
            print("Btn frame\(btn.bounds)  Point \(point)")
            let btnPosition = btn.convert(CGPoint(x: 0, y: 0), to: self.view)
            let frame = CGRect(x: btnPosition.x, y: btnPosition.y, width: btn.frame.width, height: btn.frame.height)
            if frame.contains(point) {
                btn.backgroundColor = .green
            } else {
                btn.backgroundColor = .clear
            }
        }

    }

    func dropDragableCell(sender: UIGestureRecognizer) {

        draggableLbl.removeFromSuperview()
        draggableImageView.removeFromSuperview()
        draggableView.removeFromSuperview()
        if sender.state == .ended {
            let point  = sender.location(in: view)
            for i in 0..<tileBtns.count {
                let btn = tileBtns[i]
                let btnPosition = btn.convert(CGPoint(x: 0, y: 0), to: self.view)
                let frame = CGRect(x: btnPosition.x, y: btnPosition.y, width: btn.frame.width, height: btn.frame.height)
                btn.backgroundColor = .clear
                if frame.contains(point) {
                    tileLbls[i].text = draggableLbl.text?.uppercased()
                    tileImageViews[i].image = UIImage(named: "sideBar_\(draggableLbl.text?.capitalized ?? "").png")
                    saveToCoreData(i)
                }
            }
        }
    }
}

extension HomeViewController: DCBaseDelegate {
    func showAlerts(message: String) {
        presentSingleBtnAlert(message: message)
    }
    func showReEnrollmentAlert() {
        //presentReEnrollmentAlert(message: "Hello")
        presentReEnrollmentAlertTableView(message : "Hello")
    }
}

extension UIImageView {

    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}
