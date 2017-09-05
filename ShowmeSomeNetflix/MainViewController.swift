//
//  MainViewController.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 27/5/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func createMainViewController () -> UITabBarController {
        
        // MARK: Serie list
        let serieListViewcontroller = Container.shared.seriesListBuilder().buildSeriesListModule()
        serieListViewcontroller?.tabBarItem = UITabBarItem(title: "Series",image: UIImage(named: "tv-icon"),tag: 1)
        let serieListNavigationController = UINavigationController(rootViewController: serieListViewcontroller!)
        self.configureNavigationController(navigationController: serieListNavigationController)
       
        
          // MARK: Movie list
        let movieListViewcontroller = Container.shared.movieListBuilder().buildMovieListModule()
        movieListViewcontroller?.tabBarItem = UITabBarItem(title: "Movies",image: UIImage(named: "film-icon"),tag: 2)
        let movieListNavigationController = UINavigationController(rootViewController: movieListViewcontroller!)
        self.configureNavigationController(navigationController: movieListNavigationController)
        
        
          // MARK: Favorite list
        let favoritesViewController = Container.shared.seriesListBuilder().buildSeriesListModule()
        favoritesViewController?.tabBarItem = UITabBarItem(title: "Favorites",image: UIImage(named: "towatch-icon"),tag: 3)
        let favoriteListNavigationController = UINavigationController(rootViewController: favoritesViewController!)
        self.configureNavigationController(navigationController: favoriteListNavigationController)
        
        let tabBarViewController = MainViewController()
        
        // MARK: Appearance config
        self.configureTabBarAppearance(tabBarViewController: tabBarViewController)
        
        tabBarViewController.viewControllers = [serieListNavigationController, movieListNavigationController, favoriteListNavigationController]
        tabBarViewController.centerVerticallyTabBarItems()
        
        return tabBarViewController
       
    }


    func centerVerticallyTabBarItems()  {
        
        if let items = tabBar.items {
            
            for item in items {
                item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
            }
        }
    }
    
     // MARK: Config methods
    fileprivate func configureNavigationController(navigationController: UINavigationController) {
        
        navigationController.navigationBar.barTintColor = hexStringToUIColor(hex: Constants.Colors.TabBar.kTabBarYellowColor)
        navigationController.navigationBar.tintColor =  hexStringToUIColor(hex: Constants.Colors.TabBar.kNonSelectedItemColor)
        
    }
    
    fileprivate func configureTabBarAppearance (tabBarViewController: UITabBarController){
        
        tabBarViewController.tabBar.barTintColor = hexStringToUIColor(hex: Constants.Colors.TabBar.kTabBarYellowColor)
        tabBarViewController.tabBar.tintColor = hexStringToUIColor(hex: Constants.Colors.TabBar.kNonSelectedItemColor)
    }
    

}
