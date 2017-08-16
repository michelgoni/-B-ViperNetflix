//
//  Container.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 17/5/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation

class Container {
    
     static let shared = Container()
    
    func seriesListBuilder() -> SeriesListBuilder {
        
        return SeriesListDefaultBuilder()
    }
    
    func serieDetailBuilder() -> SerieDetailBuilder {
        
        return SerieDetailDefaultBuilder()
    }
    
    func countryFlagsBuilder() -> CountryFlagsModuleBuilder {
        
        return CountryFlagsModuleDefaultBuilder()
    }
    
}

