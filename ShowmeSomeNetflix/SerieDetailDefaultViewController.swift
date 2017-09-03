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
    
    var serieId: String!
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
        
         self.presenter?.configureButton(completionHandler: { isFavorite in
            
            if isFavorite! {
                self.btnFavorite.backgroundColor = hexStringToUIColor(hex: "E85F0C")
                self.btnFavorite.setTitle("I wanna watch it", for: .normal)
            }else{
                self.btnFavorite.backgroundColor = hexStringToUIColor(hex: "FF8C0D")
                self.btnFavorite.setTitle("Not interested", for: .normal)
            }
         })
    }
    
    @IBAction func showCountries(_ sender: Any) {
        
        guard let arrayCountries = self.serieDetailModel?.arrayCountries else {
            return
        }
      self.presenter?.presentCountryFlagsForSerie(array: [arrayCountries])
    }
}

extension SerieDetailDefaultViewController: SerieDetailView {
    
    func displaySerieDetail(withSerieDetailViewmodel serieDetail: SerieDetailViewModel) {
        
        self.serieDetailModel = serieDetail
        self.serieId = serieDetail.movieId
        self.serieTitleLabel.text = serieDetail.title
        self.imdbLabel.text = serieDetail.imdbRating
        self.countryLabel.text = serieDetail.country
        self.summaryLabel.text = serieDetail.summary
        self.serieImage.kf.setImage(with: ImageResource(downloadURL: URL(string: serieDetail.image)!))
    }
    
    func displayErrorScreen() {
        
    }
}
