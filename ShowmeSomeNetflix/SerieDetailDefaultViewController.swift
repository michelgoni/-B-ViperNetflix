//
//  SerieDetailDefaultViewController.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 2/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit
import Kingfisher



class SerieDetailDefaultViewController: UIViewController {

    @IBOutlet weak var serieTitleLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var summaryLabel: UITextView!
    @IBOutlet weak var serieImage: UIImageView!
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
        
        //TODO: -- button config should be in some kind of factory

    }
    
    @IBAction func showCountries(_ sender: Any) {
        
        //TODO: Evaluate at some point if arrayCountries is available in order to make button active. App crashes sometime here if this value is not present
        
      self.presenter?.presentCountryFlagsForSerie(array: [(self.serieDetailModel?.arrayCountries)!])
    }
}

extension SerieDetailDefaultViewController: SerieDetailView {
    
    func displaySerieDetail(withSerieDetailViewmodel serieDetail: SerieDetailViewModel) {
        
        self.serieDetailModel = serieDetail
        self.serieTitleLabel.text = serieDetail.title
        self.imdbLabel.text = serieDetail.imdbRating
        self.countryLabel.text = serieDetail.country
        self.summaryLabel.text = serieDetail.summary
        self.serieImage.kf.setImage(with: ImageResource(downloadURL: URL(string: serieDetail.image)!))
    }
    
    func displayErrorScreen() {
        
    }
}
