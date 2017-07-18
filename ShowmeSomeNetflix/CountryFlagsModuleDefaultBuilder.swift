//
//  CountryFlagsModuleDefaultBuilder.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goni on 18/07/2017.
//  Copyright (c) 2016, Personal. All rights reserved.
//

import UIKit

class CountryFlagsModuleDefaultBuilder: CountryFlagsModuleBuilder {
    var router: CountryFlagsModuleRouter?
    var interactorManager: CountryFlagsModuleInteractorManager?
    var presenter: CountryFlagsModulePresenter?
    var view: CountryFlagsModuleView?

    // MARK: - CountryFlagsModuleBuilder protocol
    func buildCountryFlagsModuleModule() -> UIViewController? {
        buildView()
        buildRouter()
        buildInteractor()
        buildPresenter()
        buildCircularDependencies()
        return view as? UIViewController
    }

    // MARK: - Private
    fileprivate func buildView() {
        self.view = CountryFlagsModuleViewController()
    }

    fileprivate func buildRouter() {
        guard let view = self.view as? UIViewController else {
            assert(false, "View has to be a UIViewController")
            return
        }
        self.router = CountryFlagsModuleDefaultRouter(viewController: view)
    }

    fileprivate func buildInteractor() {
        self.interactorManager = CountryFlagsModuleDefaultInteractorManager() // TODO: set dependencies in init (use case/s, services...)
    }

    fileprivate func buildPresenter() {
        guard let interactorManager = self.interactorManager, let router = self.router, let view = self.view else {
            assert(false, "No dependencies available")
            return
        }
        self.presenter = CountryFlagsModuleDefaultPresenter(interactorManager: interactorManager, router: router, view: view)
    }

    fileprivate func buildCircularDependencies() {
        guard let presenter = self.presenter, let view = self.view as? CountryFlagsModuleViewController else {
            assert(false, "No dependencies available")
            return
        }
        view.presenter = presenter
    }
}
