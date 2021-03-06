//
//  SeriesListPresenter.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 19/5/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation

protocol SeriesListPresenter {
    
    func loadSeries()
    func searchSeries(withTerm term: String)
    func presentSerieDetail(withSerieId: String)
    
}
