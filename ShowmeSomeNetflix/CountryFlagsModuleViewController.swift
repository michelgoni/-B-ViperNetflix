//
//  CountryFlagsModuleViewController.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goni on 18/07/2017.
//  Copyright (c) 2016, Personal. All rights reserved.
//

import UIKit

class CountryFlagsModuleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var presenter: CountryFlagsModulePresenter?

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var viewModel: CountryFlagsModuleViewModel?
    var collectionViewPadding : CGFloat = 0
    let heightForImage: CGFloat = 87
    let insetCollection : CGFloat = 5
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.presenter?.loadCountryFlagsItems()
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CountryDetailCell", bundle: nil), forCellWithReuseIdentifier: "CountryCell")
        self.setUpCustomLayout()
        self.title = "Countries"
    }
    
    fileprivate func setUpCustomLayout () {
        
        let layout = ContryFlagsLayout()
        layout.numberOfColumns = 3
        collectionView.collectionViewLayout = layout
        layout.cellPadding = 5
        layout.delegate = self
    }
    
    
    //MARK:--Collection view delegates
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.countriesArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCell", for: indexPath) as! CountryCollectionViewCell
        
        if let countryName = self.viewModel?.countriesArray[indexPath.row], let countryAcronym = self.viewModel?.flagsAcronyms[indexPath.row] {
            self.configureCell(cell: cell, country: countryName, acronym: countryAcronym)
        }
       
        return cell
        
    }
    
    private func configureCell(cell: CountryCollectionViewCell, country: String, acronym: String) {
        
        cell.countryImage.image = UIImage(named: acronym + ".png")
        cell.countryLabel.text = country
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.presenter?.presentLanguagesForSerie(withView: self.view)
    }
}

extension CountryFlagsModuleViewController: RandomSizeCellsDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        
        return heightForImage
    }
    func collectionView(_ collectionView: UICollectionView, heightForTitleAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat? {
        
        return 23
    }
    
}


// MARK: - CountryFlagsModuleView
extension CountryFlagsModuleViewController: CountryFlagsModuleView {
    
    func displayCountryFlags(withCountryFlagsModuleViewModel countryFlags: CountryFlagsModuleViewModel) {
        
        self.viewModel = countryFlags
    }
}
