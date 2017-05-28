//
//  MovieViewController.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 22/1/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var movieSummary: UITextView!
    
    
    @IBOutlet weak var countryForFlagLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var audioLabel: UILabel!
    
    let dataProvider = LocalCoreDataService()
    var movie: Movie?
    
    var arrayCountries : [String] = [String]()
    var arraySubtitles = [NSArray]()
    var arrayLanguages = [NSArray]()
    var arrayForCountries = [NSArray]()
    var arrayForFlagNames = [NSArray]()


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.delegate = self
        if let movie = movie{
            
            dataProvider.searchCountryAndSubtitleForMovieByTerm(byTerm: movie.id!, remoteHandler: { movies in

                if let movie = movies?[0]{
                    
                    self.arrayCountries = NSKeyedUnarchiver.unarchiveObject(with: movie.emisionCountries!) as! [String]
                    self.arraySubtitles = NSKeyedUnarchiver.unarchiveObject(with: movie.subtitles!) as! [NSArray]
                    self.arrayLanguages = NSKeyedUnarchiver.unarchiveObject(with: movie.languages!) as! [NSArray]
                    self.arrayForFlagNames = NSKeyedUnarchiver.unarchiveObject(with: movie.flagCountries!) as! [NSArray]
                    
                    self.arrayForCountries.append(self.arrayCountries as NSArray)
                    self.arrayForCountries.append(self.arraySubtitles as NSArray)
                    self.arrayForCountries.append(self.arrayLanguages as NSArray)
                    self.arrayForCountries.append(self.arrayForFlagNames as NSArray)
                  
                }
 
            })

            
            if let image = movie.image{
                movieImg.kf.setImage(with: ImageResource(downloadURL: URL(string: image)!))
            }
            self.title = movie.title
            titleLabel.text = movie.title
            movieSummary.text = movie.summary
            imdbRatingLabel.text = movie.imdbRating
        }
        
        configureFavoriteButton()
    }
    
 
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (self.navigationController == self) {
            self.navigationController?.delegate = nil
        }
    }
    
    func configureFavoriteButton() {
        
        if let movie = self.movie {
            if dataProvider.isMovieFavorite(movie: movie) {
                btnFavorite.backgroundColor = hexStringToUIColor(hex: "E85F0C")
                btnFavorite.setTitle("I wanna watch it", for: .normal)
                
            }else{
                btnFavorite.backgroundColor = hexStringToUIColor(hex: "FF8C0D")
                btnFavorite.setTitle("Not interested", for: .normal)
            }
        }
    }
    

    
    @IBAction func favoritePressed(_ sender: Any) {
        
        if let movie = movie {
            dataProvider.markUnmarkfavorite(movie: movie)
            configureFavoriteButton()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        movieSummary.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "countriesSegue" {
            
             let countriesVC = segue.destination as! CountriesVC
            countriesVC.arrayForCountries = self.arrayForCountries
            countriesVC.movieTitle = movie?.title
           
            
        }

    }
}

extension MovieViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if fromVC == self && toVC is ListViewController {
            
            return TransitionFromSecondToFirst()
        }else if fromVC == self && toVC is MoviesViewController {
            return TransitionFromSelectedMovieToMovies()
        }else{
            return nil
        }
    }
}



