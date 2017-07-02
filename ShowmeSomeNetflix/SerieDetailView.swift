//
//  SerieDetailView.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 2/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation

protocol SerieDetailView: class {
    
    func displaySerieDetail(withSerieDetailViewmodel seriedetail: SerieDetailViewModel)
    func displayErrorScreen()
}
