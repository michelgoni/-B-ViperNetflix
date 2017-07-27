//
//  LanguagesModuleDefaultPresenter.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goni on 22/07/2017.
//  Copyright (c) 2016, Personal. All rights reserved.
//

import Foundation

struct LanguagesModuleViewModel {

}

// MARK: - Main Class
class LanguagesModuleDefaultPresenter: LanguagesModulePresenter {
    fileprivate let interactorManager: LanguagesModuleInteractorManager
    fileprivate let router: LanguagesModuleRouter
    fileprivate weak var view: LanguagesModuleView?

    fileprivate let viewModelBuilder = LanguagesModuleViewModelBuilder()

    init(interactorManager: LanguagesModuleInteractorManager, router: LanguagesModuleRouter, view: LanguagesModuleView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }

    // MARK: - LanguagesModulePresenter

}

// MARK: - Model Builder
class LanguagesModuleViewModelBuilder {
    func buildViewModel() -> LanguagesModuleViewModel {
        return LanguagesModuleViewModel()
    }
}