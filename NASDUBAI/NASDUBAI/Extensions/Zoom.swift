//
//  Zoom.swift
//  NASDUBAI
//
//  Created by MobatiaMacMini5 on 29/12/23.
//

import UIKit

extension UIView {

    func zoomIn(_ bgView: UIView? = nil, completed: @escaping () -> ())  {
        bgView?.alpha = 0.0
        self.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        }) { (finished) in
            bgView?.alpha = 0.3
            self.transform = CGAffineTransform.identity
            completed()
        }
    }

    func zoomOut(_ bgView: UIView? = nil, completed: @escaping () -> ())  {
        bgView?.alpha = 0.0
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        }) { (finished) in
            completed()
        }
    }

}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

