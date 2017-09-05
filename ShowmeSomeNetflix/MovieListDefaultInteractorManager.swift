//
//  MovieListDefaultInteractorManager.swift
//  ShowmeShomeNetflix
//
//  Created by Michel Goni on 05/09/2017.
//  Copyright (c) 2016, Michel Goni. All rights reserved.
//

import Foundation

class MovieListDefaultInteractorManager {

    let dataProvider = LocalCoreDataService()
    
    let parameters = "q=%7Bquery%7D-!1900,2017-!4,5-!8,10-!0-!Movies-!Any-!Any-!gt100-!%7Bdownloadable%7D&t=ns&cl=all&st=adv&ob=Rating&p=1"
    
}

extension MovieListDefaultInteractorManager: MovieListInteractorManager {
    
    func getMoviesList(completionHandler: @escaping ([Movie]?) -> Void) {
        
        dataProvider.getTopMovies(arguments: parameters, localHandler: { movie in
            
            //returning data from local core data
            completionHandler(movie)
        }) { movie in
            
            //returning data from remote
            completionHandler(movie)
        }
    }
    
    func getMovies(withTerm term: String, completionHandler: @escaping ([Movie]?) -> Void) {
        
        dataProvider.searchMovies(byTerm: term) { movie in
            
            completionHandler(movie)
        }
    }
}
