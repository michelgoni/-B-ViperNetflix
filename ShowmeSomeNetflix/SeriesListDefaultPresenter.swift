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
    fileprivate let serieModelBuilder = SerieListViewModelBuilder()
    
    
    init(interactorManager: SeriesListInteractorManager, router: SeriesListRouter, view: SeriesListView) {
        
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }
    
    
}

extension SeriesListDefaultPresenter: SeriesListPresenter {
    
    func loadSeries() {
        self.interactorManager.getSeriesList { movie in
            
            if let weatherViewModelToBuild = movie {
            
                let serieViewModel = self.serieModelBuilder.buildSerieListViewModel(withModel: weatherViewModelToBuild)
                self.view?.displaySeriesList(withSeriesListViewModel: serieViewModel)
            }else{
                self.view?.displayError()
            }
            
        }
    }
    
    func searchSeries(withTerm term: String) {
        
        self.interactorManager.getSeries(withTerm: term) { movie in
            
            if let serieModelToBuild = movie {
                let serieViewModel = self.serieModelBuilder.buildSerieListViewModel(withModel: serieModelToBuild)
                self.view?.displaySeriesList(withSeriesListViewModel: serieViewModel)
            }else{
                self.view?.displayError()
            }
        }
    }
    
    func presentSerieDetail(withSerieId: String) {
        
        self.router.navigateToSerieDetail(withSerieId: withSerieId)
    }
}


fileprivate class SerieListViewModelBuilder {
    
    func buildSerieListViewModel(withModel serieModel: [Movie]) -> SeriesListViewModel {
        
        var serieListViewModel: [SeriesList] = []
        
        for serieObject in serieModel {
            
            let serieModel = SeriesList(id: serieObject.id, image: serieObject.image)
            serieListViewModel.append(serieModel)
        }
        
        return SeriesListViewModel(seriesListViewModel: serieListViewModel)
    }
}
