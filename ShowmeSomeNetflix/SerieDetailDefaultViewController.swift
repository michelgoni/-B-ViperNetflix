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
    var serieId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(serieId ?? "")
        
      
    }
}

extension SerieDetailDefaultViewController: SerieDetailView {
    
    func displaySerieDetail(withSerieDetailViewmodel seriedetail: SerieDetailViewModel) {
        
        
    }
    
    func displayErrorScreen() {
        
    }
}
