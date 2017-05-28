//
//  TableViewCompatible.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 20/3/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewCompatible {
    
    var reuseIdentifier: String { get }
    
    func cellForTableView(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell
    
}

protocol Configurable {
    
    associatedtype T
    var model: T? { get set }
    func configureWithModel(_: T)
    
}
