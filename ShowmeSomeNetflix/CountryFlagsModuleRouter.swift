//
//  CountryFlagsModuleRouter.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goni on 18/07/2017.
//  Copyright (c) 2016, Personal. All rights reserved.
//

import UIKit

protocol CountryFlagsModuleRouter {
    
    func navigateToCountriesForSerie(withArrayofCountries arrayOfCountries: [Array<Any>], and view: UIView)
}
