//
//  Movie.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 22/1/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation
import UIKit

struct Movie {
    
    let id: String?
    let title: String?
    let order: Int?
    let summary: String?
    let image: String?
    let imdbRating: String?
    let category: String?
    let country : String?
    let emisionCountries: Data?
    let languages: Data?
    let subtitles: Data?
    let flagCountries: Data?
   

    
    
    init(id: String?, title: String?, order: Int?, summary: String?
        , imdbRating: String?, category: String?, image: String?, languages: Data?, subtitles: Data?, country: String?, emissionCountry: Data?, flagCountries: Data?) {
        
        self.id = id
        self.title = title
        self.order = order
        self.summary = summary
        self.imdbRating = imdbRating
        self.image = image
        self.category = category
        self.languages = languages
        self.subtitles = subtitles
        self.country = country
        self.emisionCountries = emissionCountry
        self.flagCountries = flagCountries
    }
  
    
}
