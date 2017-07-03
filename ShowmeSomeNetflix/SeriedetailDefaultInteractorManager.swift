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
    
    init(serieId: String) {
        self.serieId = serieId
    }
    
    func getSerieDetailModel() -> Movie? {
        
        return nil
    }
}
