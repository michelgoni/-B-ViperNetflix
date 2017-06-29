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


class SeriesListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: (B)Viper items
    var presenter: SeriesListPresenter?
    fileprivate var viewModel: SeriesListViewModel?
    
    
    //MARK: Collection view items
    @IBOutlet weak var collectionViewItems: UICollectionView!
     var collectionViewPadding : CGFloat = 0
    let insetCollection : CGFloat = 5
    let refresh = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Series"
        self.loadData()
        self.setUpCollectionView()
        self.setCollectionViewPadding()
        
        
    }
    
    
    //MARK: Collection view methods
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        return UIEdgeInsets(top: insetCollection, left: insetCollection, bottom: insetCollection, right: insetCollection)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return CGSize(width: 113, height: 170)
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        
//        return collectionViewPadding
//    }
    
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
    
    //MARK: Private methods

    fileprivate func setCollectionViewPadding() {
        
        let screenWidth = self.view.frame.width
        collectionViewPadding = (screenWidth - (3 * 113)) / 4
        
    }
    
    fileprivate func setUpCollectionView () {
        
        collectionViewItems.delegate = self
        collectionViewItems.dataSource = self
        
        let layout = CustomViewLayOut()
        layout.numberOfColumns = 3
        collectionViewItems.collectionViewLayout = layout
        layout.delegate = self
        collectionViewItems.register(UINib(nibName: "SerieListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SerieCell")
        
        refresh.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        collectionViewItems.refreshControl?.tintColor = UIColor.white
        collectionViewItems.refreshControl = refresh
    }
    
    func loadData() {
        
        self.presenter?.loadSeries()
    }
    
}

extension SeriesListViewController: SeriesListView {
    
   func displaySeriesList(withSeriesListViewModel serieListViewModel: SeriesListViewModel) {
    
        self.viewModel = serieListViewModel
        self.collectionViewItems.reloadData()
        self.refresh.endRefreshing()
    }
    
    func displayError() {
        
    }
}

extension SeriesListViewController: RandomSizeCellsDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        let random = arc4random_uniform(4) + 1
        return CGFloat(random * 100)
    }

    
}
