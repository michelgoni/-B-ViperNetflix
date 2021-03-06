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
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    fileprivate func countryFlagsBuilder() ->CountryFlagsModuleBuilder {
        
        return Container.shared.countryFlagsBuilder()
    }
    
    func navigateToCountriesForSerie(withArrayofCountries arrayOfCountries: [Array<Any>]) {
     
        if let countryFlagsViewController = self.countryFlagsBuilder().buildCountryFlagsModuleModule(with: arrayOfCountries) {

            self.viewController?.navigationController?.pushViewController(countryFlagsViewController, animated: true)
        }
    }
}
