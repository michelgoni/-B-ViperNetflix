//
//  SeriesListDefaultBuilder.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 17/5/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit


final class SeriesListDefaultBuilder: SeriesListBuilder {
    
    var router: SeriesListRouter?
    var interactorManager: SeriesListInteractorManager?
    var presenter: SeriesListPresenter?
    var view: SeriesListView?
 
    
    // Mark: - SeriesListBuilder protocol

    func buildSeriesListModule() -> UIViewController? {
        
        self.buildView()
        self.buildRouter()
        self.buildInteractorManager()
        self.buildPresenter()
        self.buildCircularDependencies()
        
        return self.view as? UIViewController
    }
    
    
     //MARK: - Private
    
    func buildView() {
        
        self.view = SeriesListViewController()
    }
    
    func buildRouter()  {
        
        guard let view = self.view as? UIViewController else {
            assert(false, "View has to be a UIViewController")
            return
        }
        self.router = SerieListDefaultRouter(viewController: view)
    }
    
    func buildInteractorManager() {
        
        self.interactorManager = SeriesListDefaultInteractorManager()
    }

    func buildPresenter() {
        
        guard let interactorManager = self.interactorManager,
            let router = self.router,
            let view = self.view
            else {
                assert(false, "View has to be a UIViewController")
                return
        }
        
        self.presenter = SeriesListDefaultPresenter(interactorManager: interactorManager,
                                                    router: router,
                                                    view: view)
    }
    
    func buildCircularDependencies() {
        
        guard let presenter = self.presenter, let view = self.view as? SeriesListViewController else {
            return
        }
        view.presenter = presenter
    }
}
