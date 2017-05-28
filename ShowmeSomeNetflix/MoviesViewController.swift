//
//  MoviesViewController.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 18/3/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

   
   

    @IBOutlet weak var collectionViewItems: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var movies : [Movie] = [Movie]()
    var collectionViewPadding : CGFloat = 0
    
    let refresh = UIRefreshControl()
    
    let dataProvider = LocalCoreDataService()
    
    var tapGesture : UIGestureRecognizer!
     let parameters = "q-!1900,2017-!4,5-!8,10-!0-!Movies-!Any-!Any-!gt100-!%7Bdownloadable%7D&t=ns&cl=all&st=adv&ob=Relevance&p=1"
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setCollectionViewPadding()
        
        collectionViewItems.delegate = self
        collectionViewItems.dataSource = self
        searchBar.delegate = self
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        loadData()
        
        refresh.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        collectionViewItems.refreshControl?.tintColor = UIColor.white
        collectionViewItems.refreshControl = refresh
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (self.navigationController == self) {
            self.navigationController?.delegate = nil
        }
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
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            
            loadData()
        }
    }
    
    func hideKeyboard()  {
        self.searchBar.resignFirstResponder()
        self.view.removeGestureRecognizer(tapGesture)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let term = searchBar.text {
            
            dataProvider.searchMovies(byTerm: term) {  movies in
                
                if let movies = movies {
                    
                    self.movies = movies
                    
                    DispatchQueue.main.async {
                        
                        self.collectionViewItems.reloadData()
                        searchBar.resignFirstResponder()
                    }
                }
            }
        }
    }
    
    func loadData() {
        
        dataProvider.getTopMovies(arguments: parameters, localHandler: { movies in
            if let movies = movies {
                
                self.movies = movies
                
                DispatchQueue.main.async {
                    
                    self.collectionViewItems.reloadData()
                    
                }
            }else{
                print("No records to show in Core Data")
            }
            
        }, remoteHandler: { movies in
            
            if let movies = movies {
                
                self.movies = movies
                
                DispatchQueue.main.async {
                    
                    self.collectionViewItems.reloadData()
                    self.refresh.endRefreshing()
                }
            }
        })
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            
            if let indexpathSelected = collectionViewItems.indexPathsForSelectedItems?.last {
                
                let selectedMovie = movies[indexpathSelected.row]
                
                let detailVC = segue.destination as! MovieViewController
                detailVC.movie = selectedMovie
                
            }
            hideKeyboard()
        }
    }
}

extension MoviesViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if fromVC == self && toVC is MovieViewController {
            
            return TransitionFroMoviesToSelected()
        }else{
            return nil
        }
    }
}
