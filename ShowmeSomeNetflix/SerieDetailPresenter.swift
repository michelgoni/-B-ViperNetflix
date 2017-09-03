//
//  SerieDetailPresenter.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 2/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

protocol SerieDetailPresenter {
    
    func loadData()
    func configureButton(completionHandler: @escaping (Bool?) -> Void)
    
    func presentCountryFlagsForSerie(array flagsArray: [Array<Any>])
}
