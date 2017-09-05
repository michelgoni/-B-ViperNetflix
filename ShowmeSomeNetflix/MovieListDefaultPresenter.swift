//
//  MovieListDefaultPresenter.swift
//  ShowmeShomeNetflix
//
//  Created by Michel Goni on 05/09/2017.
//  Copyright (c) 2016, Michel Goni. All rights reserved.
//

import Foundation

struct MovieListViewModel {
    
    let movieListViewModel : [MoviesList]
}

struct MoviesList {
    
    let image: String?
    let id: String?
    
    init(id: String?, image: String?) {
        self.id = id
        self.image = image
    }
}

// MARK: - Main Class
class MovieListDefaultPresenter {
    fileprivate let interactorManager: MovieListInteractorManager
    fileprivate let router: MovieListRouter
    fileprivate weak var view: MovieListView?

    fileprivate let movieModelBuilder = MovieListViewModelBuilder()

    init(interactorManager: MovieListInteractorManager, router: MovieListRouter, view: MovieListView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }

    
    // MARK: - MovieListPresenter
    

}

extension MovieListDefaultPresenter: MovieListPresenter {
    
     func loadMovies() {
        
        self.interactorManager.getMoviesList { movie in
            
             if let movieViewModelToBuild = movie {
                self.buildAndDisplayModel(movieViewModel: movieViewModelToBuild)
             }else{
                self.view?.displayError()
            }
        }
    }
    
    func searchMovies(withTerm term: String) {
        
        self.interactorManager.getMovies(withTerm: term) { movie  in
            
            if let movieViewModelToBuild = movie {
                self.buildAndDisplayModel(movieViewModel: movieViewModelToBuild)
                
            }else{
                self.view?.displayError()
            }
        }
    }
    
    func presentMoviesDetail(withMoviesId: String) {
        
    }
    
    private func buildAndDisplayModel(movieViewModel: [Movie]) {
        
        let movieViewModel = self.movieModelBuilder.buildMovieListViewModel(withModel: movieViewModel)
        self.view?.displayMoviesList(withMovieListViewModel: movieViewModel)
    }
}

// MARK: - Model Builder
class MovieListViewModelBuilder {
    
    func buildMovieListViewModel(withModel serieModel: [Movie]) -> MovieListViewModel {
        
        var movieListViewModel: [MoviesList] = []
        
        for serieObject in serieModel {
            
            let serieModel = MoviesList(id: serieObject.id, image: serieObject.image)
            movieListViewModel.append(serieModel)
        }
        
        return MovieListViewModel(movieListViewModel: movieListViewModel)
    }
}
