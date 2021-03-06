//
//  CountryFlagsModuleViewController.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goni on 18/07/2017.
//  Copyright (c) 2016, Personal. All rights reserved.
//

import UIKit
import PopupDialog

class CountryFlagsModuleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var presenter: CountryFlagsModulePresenter?

    @IBOutlet weak var searchBarViewContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
         searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        
        return searchController
    }()
    
    private var tapGesture : UIGestureRecognizer!
    var filteredFlags = [String]()
    var filteredLanguages = [[String]]()
    var flagsDictionary = [String : String]()
    var countriesIndexDict = [String : Int] ()
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
        self.setUpSearchController()
        self.title = "Countries"
    }
    
    func setUpSearchController () {
        
        searchController.searchBar.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        searchBarViewContainer.addSubview(searchController.searchBar)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barTintColor = hexStringToUIColor(hex: Constants.Colors.TabBar.kTabBarYellowColor)
        searchController.searchBar.textColor = .black
        searchController.searchBar.setMagnifyingGlassColorTo(color: .black)
        searchController.searchBar.setPlaceholderTextColor(color: .darkGray)
        searchController.searchBar.setTextFieldClearButtonColor(color: .darkGray)
        let cancelButtonAttributes: [String: AnyObject] = [NSForegroundColorAttributeName: UIColor.darkGray]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        definesPresentationContext = true
    }
    
    fileprivate func setUpCustomLayout () {
        
        let layout = ContryFlagsLayout()
        layout.numberOfColumns = 3
        collectionView.collectionViewLayout = layout
        layout.cellPadding = 5
        layout.delegate = self
    }
    
   
    
    func filterContentForSearchText(searchText: String) {
        
        filteredFlags = (self.viewModel?.countriesArray.filter { flags in
            return flags.lowercased().contains(searchText.lowercased())
            })!
        
        
         collectionView.reloadData()
    }
    
    
    //MARK:--Collection view delegates
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       if searchController.isActive {
            return filteredFlags.count
        }
        return self.viewModel?.countriesArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCell", for: indexPath) as! CountryCollectionViewCell
        
        
        if searchController.isActive && searchController.searchBar.text != "" {
        
            let countryName = filteredFlags[indexPath.row]
            let countryAcronym = flagsDictionary["\(countryName.trimmingCharacters(in: .whitespaces))"]
            self.configureCell(cell: cell, country: countryName, acronym: countryAcronym!)
            
        }else{
            if let countryName = self.viewModel?.countriesArray[indexPath.row], let countryAcronym = self.viewModel?.flagsAcronyms[indexPath.row] {
                self.configureCell(cell: cell, country: countryName, acronym: countryAcronym)
            }
        }
        return cell
    }
    
    private func configureCell(cell: CountryCollectionViewCell, country: String, acronym: String) {
        
        cell.countryImage.image = UIImage(named: acronym + ".png")
        cell.countryLabel.text = country
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //TODO: This part needs to be refactored. Showing the popUp should be responsability of the router
        
        if searchController.isActive && searchController.searchBar.text != "" {
        
            let title = filteredFlags[indexPath.row].trimmingCharacters(in: .whitespaces)
            let image = UIImage(named: flagsDictionary["\(title.trimmingCharacters(in: .whitespaces))"]! + ".png")
            
            guard let index = countriesIndexDict[title] else {
                return
            }
        
            let languages = self.viewModel!.languages[index].joined(separator: ", ")
            let subtitles = self.viewModel!.subtitles[index].joined(separator: ", ")
            
            let message = "Languages: \(languages) \n Subtitles: \(subtitles)  "
            
           
            let buttonOne = DefaultButton(title: "Ok") {
                print("Ok pressed!")
            }
            
            let popup = PopupDialog(title: title, message: message, image: image)
            popup.addButtons([buttonOne])
            
            self.present(popup, animated: true, completion: nil)
        }else{
            guard let title = self.viewModel?.countriesArray[indexPath.row].trimmingCharacters(in: .whitespaces) else {
                return
            }
            
            guard let imageName = self.viewModel?.flagsAcronyms[indexPath.row] else {
                return
            }
            
            let image = UIImage(named: imageName + ".png")
            let languages : [String] = self.viewModel!.languages[indexPath.row]
            let finalLanguages = languages.joined(separator: ", ")
            let subtitles :[String] = self.viewModel!.subtitles[indexPath.row]
            let finalSubtitles = subtitles.joined(separator: ", ")
            let message = "Languages: \(finalLanguages) \n Subtitles: \(finalSubtitles) "
            let popup = PopupDialog(title: title, message: message, image: image)
            let buttonOne = DefaultButton(title: "Ok") {
                print("Ok pressed!")
            }
            
            popup.addButtons([buttonOne])
            
            self.present(popup, animated: true, completion: nil)

        }
        
      
    }
}
   
extension CountryFlagsModuleViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let text = searchController.searchBar.text {
          filterContentForSearchText(searchText: text)
        }
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
        var i = 0
        for country in (self.viewModel?.countriesArray)!  {
            
            flagsDictionary[country.trimmingCharacters(in: .whitespaces)] = self.viewModel?.flagsAcronyms[i]
            countriesIndexDict[country.trimmingCharacters(in: .whitespaces)] = i
            i += 1
        }
    }
}
