//
//  UIImageViewExtension.swift
//  BISAD
//
//  Created by Mobatia Cathu 2 on 24/03/21.
//

import UIKit

extension UIImageView {

    func roundshape() {

        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }
}
