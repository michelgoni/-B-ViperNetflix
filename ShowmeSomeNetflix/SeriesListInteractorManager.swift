//
//  SeriesListInteractorManager.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 19/5/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation

protocol SeriesListInteractorManager {
    
    func getSeriesList(completionHandler: @escaping ([Movie]?) -> Void)
    
    func getSeries(withTerm term: String, completionHandler: @escaping ([Movie]?) -> Void)

}
