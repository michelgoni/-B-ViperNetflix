//
//  RemoteNetflixMovieService.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 22/1/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class RemoteNetflixService {
    
    let urlBase = "https://unogs-unogs-v1.p.mashape.com/api.cgi?"
    let headers: HTTPHeaders = [
        "X-Mashape-Key": "VgWOwvJzVymsh0eP3dXBIVhl39qap1wRTopjsnLt4A4ELuLmmB",
        "Accept": "application/json"
    ]
     var result = [[String: AnyObject]]()
     var movie = [String: AnyObject]()
    
    func getTopSeries(arguments: String, completionHandler: @escaping ([[String: String]]?) -> Void){
        
        let finalUrl = urlBase+arguments
        
        Alamofire.request(finalUrl, method: .get, headers: headers).validate().responseJSON() { response in
            
            switch response.result {
                
            case .success:
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    var result = [[String: String]]()
                    let entries = json["ITEMS"].arrayValue
                    
                    for entry in entries {
                        
                        var movie = [String: String]()
                        movie["id"] = entry[0].stringValue
                        movie["title"] = entry[1].stringValue
                        movie["summary"] = entry[3].stringValue
                        movie["imdbRating"] = entry[5].stringValue
                        movie["image"] = entry[2].stringValue
                        movie["category"] = entry[6].stringValue
                    
                        result.append(movie)
                        
                    }
                    completionHandler(result)
                    
                }
               
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
        }
        
    }
    
    func searchCountry(byTerm: String, completionHandler:@escaping ([[String: AnyObject]]?) -> Void)  {
    
        let endPoint = "t=loadvideo&q=\(byTerm)"
         //let finalUrl = urlBase+endPoint
        var countriesArray = [AnyObject]()
        var languagesArray = [AnyObject]()
        var subtitilesArray = [AnyObject]()
        var flagNames = [AnyObject]()
        
        var fixUrl = "https://gist.githubusercontent.com/michelgoni/de0ea41a0b98cae2e947ac1bf991d0c3/raw/a1dd73d0b2e740bcf1dfe6c84abf7ae6550fbc82/busqueda.json"
        var result = [[String: AnyObject]]()

        Alamofire.request(fixUrl, method: .get, headers: nil).validate().responseJSON() { response in
            
            switch response.result {
                
            case .success:
                
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    self.movie["id"] = json["RESULT"]["nfinfo"][10].stringValue as AnyObject?
                    self.movie["title"] = json["RESULT"]["nfinfo"][1].stringValue as AnyObject?
                    self.movie["summary"] = json["RESULT"]["nfinfo"][2].stringValue as AnyObject?
                    //TODO:-Replaced momentarely 
                    self.movie["image"] = json["RESULT"]["nfinfo"][12].stringValue as AnyObject?
                    self.movie["imdbRating"] = json["RESULT"]["nfinfo"][5].stringValue as AnyObject?
                    self.movie["category"] = json["RESULT"]["nfinfo"][6].stringValue as AnyObject?
                    self.movie["country"] = json["RESULT"]["imdbinfo"][7].stringValue as AnyObject?
                   
                    
                    //sacsmos los paises y los ponemos en un array
                    for item in json["RESULT"]["country"].arrayValue {
                        
                        countriesArray.append(item[0].stringValue as AnyObject)
                        languagesArray.append(item[6].arrayObject as AnyObject)
                        subtitilesArray.append(item[7].arrayObject as AnyObject)
                        flagNames.append(item[1].stringValue as AnyObject)
                    }
                    self.movie["countries"] = countriesArray as AnyObject?
                    self.movie["languages"] = languagesArray as AnyObject?
                    self.movie["subtitles"] = subtitilesArray as AnyObject?
                    self.movie["flagNames"] = flagNames as AnyObject?
                   
                    
                    
                   result.append(self.movie)
                     completionHandler(result)
                    

                }
                
                
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    
    
    
    func searchMovies(byTerm: String, completionHandler:@escaping ([[String: String]]?) -> Void)  {
        
        let endPoint = "q=\(byTerm)&t=ns&cl=all&st=adv&ob=Relevance&p=1"
        
        let finalUrl = urlBase+endPoint
        
        Alamofire.request(finalUrl, method: .get, headers: headers).validate().responseJSON() { response in
        
            switch response.result {
                
            case .success:
                
                var result = [[String: String]]()
                
                if let value = response.result.value {
                     let json = JSON(value)
                    let entries = json["ITEMS"].arrayValue
                    
                    for entry in entries {
                        
                        var movie = [String: String]()
                        movie["id"] = entry[0].stringValue
                        movie["title"] = entry[1].stringValue
                        movie["summary"] = entry[3].stringValue
                        movie["imdbRating"] = entry[4].stringValue
                        movie["image"] = entry[2].stringValue
                        movie["category"] = entry[6].stringValue
                        
                        result.append(movie)
                        
                    }
                    completionHandler(result)
                }
              
                
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
        }
        
    }
}
