//
//  CountryFlagsModuleDefaultPresenter.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goni on 18/07/2017.
//  Copyright (c) 2016, Personal. All rights reserved.
//

import Foundation

struct CountryFlagsModuleViewModel {

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

}

// MARK: - Model Builder
class CountryFlagsModuleViewModelBuilder {
    func buildViewModel() -> CountryFlagsModuleViewModel {
        return CountryFlagsModuleViewModel()
    }
}