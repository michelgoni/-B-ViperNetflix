//
//  MovieListDefaultBuilder.swift
//  ShowmeShomeNetflix
//
//  Created by Michel Goni on 05/09/2017.
//  Copyright (c) 2016, Michel Goni. All rights reserved.
//

import UIKit

class MovieListDefaultBuilder: MovieListBuilder {
    var router: MovieListRouter?
    var interactorManager: MovieListInteractorManager?
    var presenter: MovieListPresenter?
    var view: MovieListView?

    // MARK: - MovieListBuilder protocol
    func buildMovieListModule() -> UIViewController? {
        buildView()
        buildRouter()
        buildInteractor()
        buildPresenter()
        buildCircularDependencies()
        return view as? UIViewController
    }

    // MARK: - Private
    fileprivate func buildView() {
        self.view = MovieListViewController()
    }

    fileprivate func buildRouter() {
        guard let view = self.view as? UIViewController else {
            assert(false, "View has to be a BaseViewController")
            return
        }
        self.router = MovieListDefaultRouter(viewController: view)
    }

    fileprivate func buildInteractor() {
        self.interactorManager = MovieListDefaultInteractorManager() // TODO: set dependencies in init (use case/s, services...)
    }

    fileprivate func buildPresenter() {
        guard let interactorManager = self.interactorManager, let router = self.router, let view = self.view else {
            assert(false, "No dependencies available")
            return
        }
        self.presenter = MovieListDefaultPresenter(interactorManager: interactorManager, router: router, view: view)
    }

    fileprivate func buildCircularDependencies() {
        guard let presenter = self.presenter, let view = self.view as? MovieListViewController else {
            assert(false, "No dependencies available")
            return
        }
        view.presenter = presenter
    }
}
