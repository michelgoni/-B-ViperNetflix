//
//  MovieListPresenter.swift
//  ShowmeShomeNetflix
//
//  Created by Michel Goni on 05/09/2017.
//  Copyright (c) 2016, Michel Goni. All rights reserved.
//

import Foundation

protocol MovieListPresenter {
    
    func loadMovies()
    func searchMovies(withTerm term: String)
    func presentMoviesDetail(withMoviesId: String)

}
