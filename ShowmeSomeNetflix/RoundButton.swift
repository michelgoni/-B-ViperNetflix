//
//  RoundButton.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 17/3/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? = UIColor.clear {
        didSet {
            layer.borderColor = borderColor?.cgColor
            
        }
    }
    
    @IBInspectable var colorBackground: UIColor? = UIColor.clear {
        didSet {
            layer.backgroundColor = colorBackground?.cgColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}


