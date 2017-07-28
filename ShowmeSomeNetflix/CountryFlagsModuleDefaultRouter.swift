//
//  CountryFlagsModuleDefaultRouter.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goni on 18/07/2017.
//  Copyright (c) 2016, Personal. All rights reserved.
//

import UIKit

class CountryFlagsModuleDefaultRouter: CountryFlagsModuleRouter {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    fileprivate func languagesModuleBuilder()-> LanguagesModuleBuilder {
        
        return Container.shared.languagesModuleBuilder()
    }

    // MARK - Navigation funcions
   func navigateToCountriesForSerie(withArrayofCountries arrayOfCountries: [Array<Any>], andView view: UIView) {
        
        if let languagesViewController = self.languagesModuleBuilder().buildLanguagesModuleModule(with: arrayOfCountries) {
            
            languagesViewController.showInView(view, animated: true)
            
        }
    }

}
