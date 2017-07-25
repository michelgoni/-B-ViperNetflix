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

    // MARK - Navigation funcions
    func navigateToCountriesForSerie(withArrayofCountries arrayOfCountries: [Array<Any>]) {
        
    }

}
