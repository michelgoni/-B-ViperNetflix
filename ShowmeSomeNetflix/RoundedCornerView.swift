//
//  RoundedCornerView.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 22/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

class RoundedCornerView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

}
