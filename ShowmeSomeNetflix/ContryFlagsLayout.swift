//
//  ContryFlagsLayout.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 18/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

class ContryFlagsLayout: UICollectionViewLayout {

    
    var numberOfColumns = 0
    var cache = [CustomLayoutAttributes]()
    var cellPadding: CGFloat = 0
    fileprivate var contentHeight: CGFloat = 0
    fileprivate let cellHeight: CGFloat = 113.0
    var delegate: RandomSizeCellsDelegate!
    fileprivate var width: CGFloat {
        get {
            let insets = collectionView!.contentInset
            return collectionView!.bounds.width - (insets.left + insets.right)
        }
    }
    
    override class var layoutAttributesClass : AnyClass {
        return CustomLayoutAttributes.self
    }
    
    override var collectionViewContentSize : CGSize {
        return CGSize(width: width, height: contentHeight)
    }
    
    
    override func prepare() {
        
        cache.removeAll()
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
                let width = columnWidth - (cellPadding * 2)
                let imageHeight = delegate.collectionView(collectionView!, heightForImageAtIndexPath: indexPath, withWidth: width)
                let height = cellPadding + imageHeight  + cellPadding
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                let attributes = CustomLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                attributes.imageHeight = height
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
