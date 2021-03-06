//
//  CountryFlagsModuleBuilder.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goni on 18/07/2017.
//  Copyright (c) 2016, Personal. All rights reserved.
//

import UIKit

protocol CountryFlagsModuleBuilder {
    func buildCountryFlagsModuleModule(with flagsArray: [Array<Any>]) -> CountryFlagsModuleViewController?
}
