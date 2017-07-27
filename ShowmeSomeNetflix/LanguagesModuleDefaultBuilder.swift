//
//  LanguagesModuleDefaultBuilder.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goni on 22/07/2017.
//  Copyright (c) 2016, Personal. All rights reserved.
//

import UIKit

class LanguagesModuleDefaultBuilder: LanguagesModuleBuilder {
    var router: LanguagesModuleRouter?
    var interactorManager: LanguagesModuleInteractorManager?
    var presenter: LanguagesModulePresenter?
    var view: LanguagesModuleView?

    // MARK: - LanguagesModuleBuilder protocol
    func buildLanguagesModuleModule() -> UIViewController? {
        buildView()
        buildRouter()
        buildInteractor()
        buildPresenter()
        buildCircularDependencies()
        return view as? UIViewController
    }

    // MARK: - Private
    fileprivate func buildView() {
        self.view = LanguagesModuleViewController()
    }

    fileprivate func buildRouter() {
        guard let view = self.view as? UIViewController else {
            assert(false, "View has to be a UIViewController")
            return
        }
        self.router = LanguagesModuleDefaultRouter(viewController: view)
    }

    fileprivate func buildInteractor() {
        self.interactorManager = LanguagesModuleDefaultInteractorManager() // TODO: set dependencies in init (use case/s, services...)
    }

    fileprivate func buildPresenter() {
        guard let interactorManager = self.interactorManager, let router = self.router, let view = self.view else {
            assert(false, "No dependencies available")
            return
        }
        self.presenter = LanguagesModuleDefaultPresenter(interactorManager: interactorManager, router: router, view: view)
    }

    fileprivate func buildCircularDependencies() {
        guard let presenter = self.presenter, let view = self.view as? LanguagesModuleViewController else {
            assert(false, "No dependencies available")
            return
        }
        view.presenter = presenter
    }
}