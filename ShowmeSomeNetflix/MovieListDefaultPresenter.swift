//
//  MovieListDefaultPresenter.swift
//  ShowmeShomeNetflix
//
//  Created by Michel Goni on 05/09/2017.
//  Copyright (c) 2016, Michel Goni. All rights reserved.
//

import Foundation

struct MovieListViewModel {

}

// MARK: - Main Class
class MovieListDefaultPresenter: MovieListPresenter {
    fileprivate let interactorManager: MovieListInteractorManager
    fileprivate let router: MovieListRouter
    fileprivate weak var view: MovieListView?

    fileprivate let viewModelBuilder = MovieListViewModelBuilder()

    init(interactorManager: MovieListInteractorManager, router: MovieListRouter, view: MovieListView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }

    // MARK: - MovieListPresenter

}

// MARK: - Model Builder
class MovieListViewModelBuilder {
    func buildViewModel() -> MovieListViewModel {
        return MovieListViewModel()
    }
}