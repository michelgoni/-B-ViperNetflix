//
//  MovieListViewController.swift
//  ShowmeShomeNetflix
//
//  Created by Michel Goni on 05/09/2017.
//  Copyright (c) 2016, Michel Goni. All rights reserved.
//

import UIKit
import Kingfisher
import GoogleMobileAds
import SwiftSpinner
import AVFoundation

class MovieListViewController:  UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    var presenter: MovieListPresenter?
    fileprivate var viewModel: MovieListViewModel?
     //MARK: Collection view items
    @IBOutlet weak var collectionViewItems: UICollectionView!
    var collectionViewPadding : CGFloat = 0
    let heightForImage: CGFloat = 156
    let insetCollection : CGFloat = 5
    let refresh = UIRefreshControl()
    
     //MARK: SearchBar items
    @IBOutlet weak var searchBar: UISearchBar!
    var tapGesture : UIGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        self.loadData()
        self.setUpCollectionView()
        self.setUpSearchBar()
        self.setUpCustomLayout()
    }
    
    //MARK: Collection view methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movieListViewModel.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SerieCell", for: indexPath) as! MovieCell
        
        return cell
    }
    
    func loadData() {
        
        self.presenter?.loadMovies()
    }
    
    
    //MARK: fileprivate implementations
    fileprivate func setUpCollectionView () {
        
        collectionViewItems.delegate = self
        collectionViewItems.dataSource = self
        collectionViewItems!.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)
        collectionViewItems.register(UINib(nibName: "SerieListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SerieCell")
        
        refresh.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        collectionViewItems.refreshControl?.tintColor = UIColor.white
        collectionViewItems.refreshControl = refresh
    }
    
    fileprivate func setUpCustomLayout () {
        
        let layout = CustomViewLayOut()
        layout.numberOfColumns = 3
        collectionViewItems.collectionViewLayout = layout
        layout.cellPadding = 5
        layout.delegate = self
    }
    
    fileprivate func setUpSearchBar() {
        
        searchBar.delegate = self
        searchBar.textColor = .black
        searchBar.setMagnifyingGlassColorTo(color: .black)
        searchBar.setPlaceholderTextColor(color: .darkGray)
        searchBar.setTextFieldClearButtonColor(color: .darkGray)
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(MovieListViewController.hideKeyboard))
    }
    
    @objc fileprivate func hideKeyboard()  {
        self.searchBar.resignFirstResponder()
        self.view.removeGestureRecognizer(tapGesture)
    }

}

// MARK: - MovieListView
extension MovieListViewController: MovieListView {
    
    func displayMoviesList(withMovieListViewModel movieListViewModel: MovieListViewModel) {
        
        print(movieListViewModel)
        
    }
    
    func displayError() {
        
    }
}

extension MovieListViewController: RandomSizeCellsDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        
        return heightForImage
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForTitleAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat? {
        
        return nil
    }
}
