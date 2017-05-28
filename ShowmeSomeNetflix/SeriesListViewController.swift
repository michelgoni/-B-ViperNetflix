//
//  SeriesListViewController.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 19/5/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit


class SeriesListViewController: UIViewController {
    
    var presenter: SeriesListPresenter?
    fileprivate var viewModel: SeriesListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Series"
        self.presenter?.loadSeries()
        
    }

  
}

extension SeriesListViewController: SeriesListView {
    
    func displaySeriesList(withSeriesListViewModel: SeriesListViewModel) {
        
    }
    
    func displayError() {
        
    }
}
