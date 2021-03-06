//
//  MovieListInteractorManager.swift
//  ShowmeShomeNetflix
//
//  Created by Michel Goni on 05/09/2017.
//  Copyright (c) 2016, Michel Goni. All rights reserved.
//

import Foundation

protocol MovieListInteractorManager {
    
    func getMoviesList(completionHandler: @escaping ([Movie]?) -> Void)
    
    func getMovies(withTerm term: String, completionHandler: @escaping ([Movie]?) -> Void)

}
