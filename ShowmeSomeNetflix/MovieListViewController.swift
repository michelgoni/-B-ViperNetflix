//
//  MovieListViewController.swift
//  ShowmeShomeNetflix
//
//  Created by Michel Goni on 05/09/2017.
//  Copyright (c) 2016, Michel Goni. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    var presenter: MovieListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - MovieListView
extension MovieListViewController: MovieListView {
    
    func displaySeriesList(withSeriesListViewModel serieListViewModel: MovieListViewModel) {
        
    }
    
    func displayError() {
        
    }

}
