//
//  FavoritesViewController.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 22/1/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit
import Kingfisher

class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    var collectionViewPadding: CGFloat = 0
    let dataProvider = LocalCoreDataService()
    var movies: [Movie] = [Movie]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setCollectionViewPadding()
        
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    
    func setCollectionViewPadding() {
        
        let screenWidth = self.view.frame.width
        collectionViewPadding = (screenWidth - (3 * 113)) / 4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: collectionViewPadding, left: collectionViewPadding, bottom: collectionViewPadding, right: collectionViewPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 113, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return collectionViewPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if movies.count > 0 {
            self.favoritesCollectionView.backgroundView = nil
        }else{
            let imageView  = UIImageView(image: UIImage(named: "sin-favoritas"))
            imageView.contentMode = .center
            self.favoritesCollectionView.backgroundView = imageView
        }
        
        
        return movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        
        self.configureCell(cell: cell, withMovie: movie)
        
        return cell
        
    }
    
    func configureCell(cell: MovieCell, withMovie movie: Movie) {
        
        if let image = movie.image {
            
            cell.movieImage.kf.setImage(with: ImageResource(downloadURL: URL(string: image)!), placeholder: #imageLiteral(resourceName: "img-loading"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    
    
    func loadData() {
        
        if let movies = dataProvider.getFavoriteMovies() {
            
            self.movies = movies
            self.favoritesCollectionView.reloadData()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexpathSelected = favoritesCollectionView.indexPathsForSelectedItems?.last {
                let selectedMovie = movies[indexpathSelected.row]
                let detailVC = segue.destination as! MovieViewController
                detailVC.movie = selectedMovie
            }

        }
    }
}
