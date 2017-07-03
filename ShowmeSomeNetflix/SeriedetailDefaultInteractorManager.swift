//
//  SeriedetailDefaultInteractorManager.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 2/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation

class SerieDetailDefaultInteractorManager: SerieDetailInteractorManager {
    
    let serieId: String
    let dataProvider = LocalCoreDataService()
    
    init(serieId: String) {
        self.serieId = serieId
    }
    
    func getSerieDetailModel(completionHandler: @escaping (Movie?) -> Void) {
        
        dataProvider.searchCountryAndSubtitleForMovieByTerm(byTerm: serieId) { serieDetail in
          
            if let serieDetail = serieDetail?.first {
                completionHandler(serieDetail)
            }
        }
        
    }
}
