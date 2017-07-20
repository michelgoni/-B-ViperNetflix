//
//  SerieDetaildefaultPresenter.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 2/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

struct SerieDetailViewModel {
    
    let title: String
    let summary: String
    let image: String
    let imdbRating: String
    let country: String
    let arrayCountries: [[Any]]
    
    fileprivate let serieDetailModelBuilder = SerieDetailViewModelBuilder()
    
    
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
        
        self.interactorManager.getSerieDetailModel { serieDetail in
            
            if let serieDetail = serieDetail {
             
                let serieDetailViewModel = self.serieDetailModelBuilder.buildSerieDetailWithSerieModel(serieDetail: serieDetail)
                self.view?.displaySerieDetail(withSerieDetailViewmodel: serieDetailViewModel)
            }
        }
    }
    
    func presentCountryFlagsForSerie(array flagsArray: [Array<Any>], and view: UIView){
        
        self.router.navigateToCountriesForSerie(withArrayofCountries: flagsArray, and: view)
    }
}

fileprivate class SerieDetailViewModelBuilder {
    
    func buildSerieDetailWithSerieModel(serieDetail: Movie) -> SerieDetailViewModel {
        
        let emission = [NSKeyedUnarchiver.unarchiveObject(with: serieDetail.emisionCountries!) as! [String],
                        NSKeyedUnarchiver.unarchiveObject(with: serieDetail.flagCountries!) as! [String],
                        NSKeyedUnarchiver.unarchiveObject(with: serieDetail.subtitles!)!,
                        NSKeyedUnarchiver.unarchiveObject(with: serieDetail.languages!)!]
       
        
        
        
        return SerieDetailViewModel(title: serieDetail.title!, summary: serieDetail.summary!, image: serieDetail.image!,imdbRating: serieDetail.imdbRating!, country: serieDetail.country!, arrayCountries: [emission])

        
        
        
       
        
       
    
    }
}
