//
//  CountryCollectionViewCell.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 13/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attributes = layoutAttributes as! CustomLayoutAttributes
        imageHeightConstraint.constant = attributes.imageHeight
    }
    
}
