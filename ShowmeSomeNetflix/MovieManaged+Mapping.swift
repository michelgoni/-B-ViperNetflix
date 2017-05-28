//
//  MovieManaged+Mapping.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 22/1/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation

extension MovieManaged {
    
    func mappedObject() -> Movie {
        
        return Movie(id: self.id,
                     title: self.title,
                     order: Int(self.order),
                     summary: self.summary,
                     imdbRating: self.imdbRating,
                     category: self.category,
                     image: self.image,
                     languages: self.language as Data? ,
                     subtitles: self.subtitle as Data? ,
                     country: self.country,
                     emissionCountry: self.emissionCountries as Data?,
                     flagCountries:self.flagCountries as Data?)
        
    }
}

