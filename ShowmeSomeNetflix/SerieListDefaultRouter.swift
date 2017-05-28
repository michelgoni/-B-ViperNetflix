//
//  SerieListDefaultRouter.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 19/5/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

class SerieListDefaultRouter {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    
}

extension SerieListDefaultRouter: SeriesListRouter {
    
    func navigateToSerieDetail(withSerieId serieId: String) {
        
    }
}
