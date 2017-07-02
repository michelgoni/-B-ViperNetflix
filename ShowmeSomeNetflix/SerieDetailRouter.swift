//
//  SerieDetailRouter.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 2/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation

protocol SerieDetailRouter {
    
    func navigateToCountriesForSerie(withArrayofCountries arrayOfCountries: [Array<Any>], andMovieTitle title: String)
}
