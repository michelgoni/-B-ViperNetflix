//
//  CustomViewLayOut.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 29/6/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit


protocol RandomSizeCellsDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
}

class CustomViewLayOut: UICollectionViewLayout {

    var numberOfColumns = 0
    var cache = [UICollectionViewLayoutAttributes]()
    var cellPadding: CGFloat = 0
    fileprivate var contentHeight: CGFloat = 0
    fileprivate let cellHeight: CGFloat = 170.0
    var delegate: RandomSizeCellsDelegate!
    fileprivate var width: CGFloat {
        get {
            let insets = collectionView!.contentInset
            return collectionView!.bounds.width - (insets.left + insets.right)
        }
    }
    
    override var collectionViewContentSize : CGSize {
        return CGSize(width: width, height: contentHeight)
    }
    
    
    override func prepare() {
        if cache.isEmpty {
            let columnWidth = width / CGFloat(numberOfColumns)
            
            var xOffsets = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
            
            var column = 0
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                let height = delegate.collectionView(collectionView!, heightForItemAtIndexPath: indexPath)
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding) 
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY)
                yOffsets[column] = yOffsets[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}