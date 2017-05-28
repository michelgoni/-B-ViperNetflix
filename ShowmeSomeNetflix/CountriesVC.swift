//
//  CountriesVC.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 5/3/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit
import AVFoundation
import QuartzCore



class CountriesVC: UITableViewController {

    var arrayForCountries =  [NSArray]()
    var movieTitle: String!
    var arrayForAudio = [String]()
    var arrayForSubtitles = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieTitle
        tableView.rowHeight = 145
        
        navigationController?.navigationBar.topItem?.title = ""
        
        for audioArray in arrayForCountries[2] {
            
            var stringAudio = (audioArray as AnyObject).componentsJoined(by: ", ").replacingOccurrences(of: "English - Audio Description", with: "")
            stringAudio = stringAudio.replacingOccurrences(of: ",,", with: ", ").replacingOccurrences(of: ", ,", with: ",")
            
            if stringAudio[0] == "," {
                
                let newString = stringAudio.substring(from: 1)
                arrayForAudio.append(newString)
                
            }else{
                arrayForAudio.append(stringAudio)

            }
           
        }
        
        for subtitleArray in arrayForCountries[1] {
         
            let stringSubtitile = (subtitleArray as AnyObject).componentsJoined(by: ", ")
            arrayForSubtitles.append(stringSubtitile)
            
            
        }
  
    
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayForCountries[0].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
        cell.imgForCountry.image = UIImage(named:  arrayForCountries[3][indexPath.row] as! String + ".png")
        cell.countryLabel.text = arrayForCountries[0][indexPath.row] as? String
        cell.audioLabel.text = arrayForAudio[indexPath.row]
        cell.subtitleLabel.text = arrayForSubtitles[indexPath.row]
    
        return cell
    }
}




