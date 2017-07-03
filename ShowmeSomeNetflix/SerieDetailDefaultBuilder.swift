//
//  SerieDetailDefaultBuilder.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 2/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

class SerieDetailDefaultBuilder: SerieDetailBuilder {
    
    var presenter: SerieDetailPresenter?
    var interactorManager: SerieDetailInteractorManager?
    var view: SerieDetailView?
    var router: SerieDetailRouter?
    
    func buildSerieDetailModule(withSerieid serieId: String) -> UIViewController? {
        
        self.buildView()
        self.buildRouter()
        self.buildInteractorManager(withSerieId: serieId)
        self.buildPresenter()
        self.buildCircularDependencies()
        
        return self.view as? UIViewController
    }
    
    func buildView() {
        
        self.view = SerieDetailDefaultViewController()
    }
    
    func buildRouter()  {
        
        guard let view = self.view as? UIViewController else {
            assert(false, "View has to be a UIViewController")
            return
        }
        self.router = SerieDetailDefaultRouter(viewController: view)
    }
    func buildInteractorManager(withSerieId serieId: String) {
        
        self.interactorManager = SerieDetailDefaultInteractorManager(serieId: serieId)
    }
    
    func buildPresenter() {
        
        guard let interactorManager = self.interactorManager,
            let router = self.router,
            let view = self.view
            else {
                assert(false, "View has to be a UIViewController")
                return
        }
        
        self.presenter = SeriedetailDefaultPresenter(interactorManager: interactorManager, router: router, view: view)
    }
    
    func buildCircularDependencies() {
        
        guard let presenter = self.presenter, let view = self.view as? SerieDetailDefaultViewController else {
            return
        }
        view.presenter = presenter
    }

}
