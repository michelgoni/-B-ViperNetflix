//
//  SeriesListView.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 19/5/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation

protocol SeriesListView: class {
    
    func displaySeriesList(withSeriesListViewModel serieListViewModel: SeriesListViewModel)
    func displayError()
    
}
