//
//  SerieDetailDefaultRouter.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 2/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

class SerieDetailDefaultRouter: SerieDetailRouter {
    
    weak var viewController: UIViewController?
     var popViewController : CountriesDetailDefaultViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    fileprivate func countryFlagsBuilder() ->CountryFlagsModuleBuilder {
        
        return Container.shared.countryFlagsBuilder()
    }
    
    func navigateToCountriesForSerie(withArrayofCountries arrayOfCountries: [Array<Any>], and view: UIView) {
     
        if let countryFlagsViewController = self.countryFlagsBuilder().buildCountryFlagsModuleModule(with: arrayOfCountries) {
            
//            self.popViewController = CountriesDetailDefaultViewController(nibName: "DetailViewCountries", bundle: nil)
//            self.popViewController?.showInView(self.view, withImage: nil, withMessage: nil, animated: true)
          
            self.viewController?.navigationController?.pushViewController(countryFlagsViewController, animated: true)
            
        }
    }
}
