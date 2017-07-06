//
//  SerieDetailDefaultViewController.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 2/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

class SerieDetailDefaultViewController: UIViewController {
    

    var presenter: SerieDetailPresenter?
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.loadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
}

extension SerieDetailDefaultViewController: SerieDetailView {
    
    func displaySerieDetail(withSerieDetailViewmodel serieDetail: SerieDetailViewModel) {
        
        print(serieDetail)
    }
    
    func displayErrorScreen() {
        
    }
}
