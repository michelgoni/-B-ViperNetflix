//
//  SerieDetaildefaultPresenter.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 2/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation

struct SerieDetailViewModel {
    
    let title: String
    let summary: String
    let imdbRating: String
    let country: String
    let arrayCountries: [String]
    
    
}

class SeriedetailDefaultPresenter: SerieDetailPresenter {
    
    fileprivate let interactorManager: SerieDetailInteractorManager
    fileprivate let router: SerieDetailRouter
    fileprivate weak var view: SerieDetailView?
    fileprivate let serieDetailModelBuilder = SerieDetailViewModelBuilder()
    
    init(interactorManager: SerieDetailInteractorManager, router: SerieDetailRouter, view: SerieDetailView) {
        
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }
    
    var arrayForCountries = [NSArray]()
    var arrayForFlagNames = [NSArray]()
    var arraySubtitles = [NSArray]()
    var arrayLanguages = [NSArray]()
    
    func loadData() {
        
    }
}

fileprivate class SerieDetailViewModelBuilder {
    
    
}
