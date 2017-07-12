
//
//  SeriesListViewController.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 19/5/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit
import Kingfisher
import GoogleMobileAds
import SwiftSpinner
import AVFoundation


class SeriesListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    //MARK: (B)Viper items
    var presenter: SeriesListPresenter?
    fileprivate var viewModel: SeriesListViewModel?

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
        self.title = "Series"
        self.loadData()
        self.setUpCollectionView()
        self.setUpSearchBar()
        self.setUpCustomLayout()
    }
    
    
    
    //MARK: Collection view methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.seriesListViewModel.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let serieModel = viewModel?.seriesListViewModel[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SerieCell", for: indexPath) as! MovieCell
        
        self.configureCell(cell: cell, withSerie: serieModel!)
        
        return cell
        
    }
    
    func configureCell(cell: MovieCell, withSerie serie: SeriesList) {
        
        if let image = serie.image {
            
            cell.movieImage.kf.setImage(with: ImageResource(downloadURL: URL(string: image)!), placeholder: #imageLiteral(resourceName: "img-loading"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if let serieId = self.viewModel?.seriesListViewModel[indexPath.row].id {
         
            self.presenter?.presentSerieDetail(withSerieId: serieId)
        }
    }

    func loadData() {
        
        self.presenter?.loadSeries()
    }
    
    //MARK: SearchBar delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let term = searchBar.text {
           self.presenter?.searchSeries(withTerm: term)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            
            self.loadData()
        }
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
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(SeriesListViewController.hideKeyboard))
    }
    
    @objc fileprivate func hideKeyboard()  {
        self.searchBar.resignFirstResponder()
        self.view.removeGestureRecognizer(tapGesture)
    }
}

extension SeriesListViewController: SeriesListView {
    
   func displaySeriesList(withSeriesListViewModel serieListViewModel: SeriesListViewModel) {
    
        self.viewModel = serieListViewModel
        DispatchQueue.main.async {
        self.collectionViewItems.reloadData()
        self.collectionViewItems.collectionViewLayout.invalidateLayout()
        self.refresh.endRefreshing()
        }
    }
    
    func displayError() {
        
    }
}

extension SeriesListViewController: RandomSizeCellsDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        
        //In case we should hace dynamic images. But since all images share same size, retuning a constant so far is ok
//        let data = try! Data(contentsOf: URL(string: (viewModel?.seriesListViewModel[indexPath.row].image)!)!)
//        let image = UIImage(data: data)
//        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
//        let rect = AVMakeRect(aspectRatio: (image?.size)! , insideRect: boundingRect)
        
        return heightForImage
    }
}
