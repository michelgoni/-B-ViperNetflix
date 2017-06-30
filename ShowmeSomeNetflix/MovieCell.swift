//
//  MovieCell.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 22/1/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.frame.size.width * 0.125
        self.layer.borderWidth = 1
       
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attributes = layoutAttributes as! CustomLayoutAttributes
        imageHeightConstraint.constant = attributes.imageHeight
    }

    
}

class ResultCell: UITableViewCell {
    
    @IBOutlet weak var imgForCountry: UIImageView!
    @IBOutlet weak var audioLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func layoutSubviews() {
        imgForCountry.round()
    }
    
  
}

public extension UIView {
    public func round() {
        let width = bounds.width < bounds.height ? bounds.width : bounds.height
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(ovalIn: CGRect(x: bounds.midX - width / 2, y: bounds.midY - width / 2, width: width, height: width)).cgPath
        self.layer.mask = mask
    }
}

