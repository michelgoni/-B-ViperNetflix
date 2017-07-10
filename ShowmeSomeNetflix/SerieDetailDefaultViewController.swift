//
//  SerieDetailDefaultViewController.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 2/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

class SerieDetailDefaultViewController: UIViewController {

    @IBOutlet weak var serieTitleLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var summaryLabel: UITextView!
    @IBOutlet weak var btnFavorite: RoundButton!
   
    var presenter: SerieDetailPresenter?
    var serieDetailModel : SerieDetailViewModel?
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.loadData()
        self.configureButton()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    //MARK: Private
    func configureButton() {
        
        

    }
    
    
}

extension SerieDetailDefaultViewController: SerieDetailView {
    
    func displaySerieDetail(withSerieDetailViewmodel serieDetail: SerieDetailViewModel) {
        
       self.serieDetailModel = serieDetail
        
        
    }
    
    func displayErrorScreen() {
        
    }
}
