//
//  SeriesListDefaultPresenter.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 19/5/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation


struct SeriesListViewModel {
    
    let seriesListViewModel : [SeriesList]
}


struct SeriesList {
    
    let image: String?
    let id: String?
    
    init(id: String?, image: String?) {
        self.id = id
        self.image = image
    }
}

class SeriesListDefaultPresenter {
    
    
    fileprivate let interactorManager: SeriesListInteractorManager
    fileprivate let router: SeriesListRouter
    fileprivate weak var view: SeriesListView?
    
    init(interactorManager: SeriesListInteractorManager, router: SeriesListRouter, view: SeriesListView) {
        
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }
    
    
}

extension SeriesListDefaultPresenter: SeriesListPresenter {
    
    func loadSeries() {
        self.interactorManager.getSeriesList()
    }
    
    func presentSerieDetail(withSerieId: SeriesList) {
        
    }
}
