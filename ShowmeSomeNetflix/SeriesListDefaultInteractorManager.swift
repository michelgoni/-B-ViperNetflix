//
//  SeriesListDefaultInteractorManager.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 19/5/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation

class SeriesListDefaultInteractorManager {
    
      let dataProvider = LocalCoreDataService()
    
}

extension SeriesListDefaultInteractorManager: SeriesListInteractorManager {
    
    func getSeriesList() -> [Movie]? {
        
        dataProvider.getTopMovies(arguments: "", localHandler: { movie in
            //
        }) { movie in
            
        }
        
        return nil
    }
}
