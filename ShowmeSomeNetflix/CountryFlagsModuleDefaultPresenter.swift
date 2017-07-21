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
}

// MARK: - Model Builder
class CountryFlagsModuleViewModelBuilder {
    func buildViewModel(countryFlagsItems: [Array<Any>]) -> CountryFlagsModuleViewModel {
        return CountryFlagsModuleViewModel(countriesArray: countryFlagsItems[0][0] as! [String], flagsAcronyms: countryFlagsItems[0][1] as! [String])
    }
}
