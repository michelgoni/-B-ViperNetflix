//
//  CountryFlagsModuleDefaultPresenter.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goni on 18/07/2017.
//  Copyright (c) 2016, Personal. All rights reserved.
//

import Foundation

struct CountryFlagsModuleViewModel {
    
    let countriesArray: [String]
    let flagsAcronyms: [String]
    let languages: [Array<Any>]
    let subtitles: [Array<Any>]
    
}

// MARK: - Main Class
class CountryFlagsModuleDefaultPresenter: CountryFlagsModulePresenter {
    fileprivate let interactorManager: CountryFlagsModuleInteractorManager
    fileprivate let router: CountryFlagsModuleRouter
    fileprivate weak var view: CountryFlagsModuleView?

    fileprivate let viewModelBuilder = CountryFlagsModuleViewModelBuilder()

    init(interactorManager: CountryFlagsModuleInteractorManager, router: CountryFlagsModuleRouter, view: CountryFlagsModuleView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }

    // MARK: - CountryFlagsModulePresenter
    func loadCountryFlagsItems() {
        self.interactorManager.getFlagsItems { flagsArray in
            
          
            let countryFlagsViewModel = self.viewModelBuilder.buildViewModel(countryFlagsItems: flagsArray)
           self.view?.displayCountryFlags(withCountryFlagsModuleViewModel: countryFlagsViewModel)
        }
    }
    
    func presentLanguagesForSerie() {
        
        
    }
}

// MARK: - Model Builder
class CountryFlagsModuleViewModelBuilder {
    func buildViewModel(countryFlagsItems: [Array<Any>]) -> CountryFlagsModuleViewModel {
        return CountryFlagsModuleViewModel(countriesArray: countryFlagsItems[0][0] as! [String], flagsAcronyms: countryFlagsItems[0][1] as! [String], languages: countryFlagsItems[0][2] as! [Array<Any>], subtitles: countryFlagsItems[0][3] as! [Array<Any>])
    }
}
