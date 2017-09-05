//
//  SeriesListDefaultInteractorManager.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 19/5/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SeriesListDefaultInteractorManager {
    
      let dataProvider = LocalCoreDataService()
    
    let parameters = "q=%7Bquery%7D-!1900,2017-!4,5-!8,10-!0-!Series-!Any-!Any-!gt100-!%7Bdownloadable%7D&t=ns&cl=all&st=adv&ob=Rating&p=1"

}

extension SeriesListDefaultInteractorManager: SeriesListInteractorManager {
    
    func getSeriesList(completionHandler: @escaping ([Movie]?) -> Void) {
        
        dataProvider.getTopMovies(arguments: parameters, localHandler: { movie in
            
            //returning data from local core data
            completionHandler(movie)
        }) { movie in
            
            //returning data from remote
            completionHandler(movie)
        }
    }
    
    func getSeries(withTerm term: String, completionHandler: @escaping ([Movie]?) -> Void) {
        
       dataProvider.searchMovies(byTerm: term) { movie in
        
            completionHandler(movie)
        }
    }
}
