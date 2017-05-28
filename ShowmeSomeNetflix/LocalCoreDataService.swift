//
//  LocalCoreDataService.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 22/1/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation
import CoreData

class LocalCoreDataService {
    
    let remoteService = RemoteNetflixService()
    let stack = CoreDataStack.sharedInstance
    
    func searchMovies(byTerm: String, remoteHandler:@escaping([Movie]?)->Void) {
        
        remoteService.searchMovies(byTerm: byTerm) { movies in
            
            if let movies = movies {
                
                var modelMovies = [Movie]()
                
                for movie in movies {
                    
                    let modelMovie = Movie(id: movie["id"], title: movie["title"], order: nil, summary: movie["summary"], imdbRating: movie["imdbRating"], category: movie["category"], image: movie["image"], languages: nil, subtitles: nil, country: nil, emissionCountry: nil , flagCountries: nil)
                    
                    modelMovies.append(modelMovie)
                }
                remoteHandler(modelMovies)
                
            }else{
                print("Error bringing REST Movies")
                remoteHandler(nil)
            }
        }
    }
    

    
    func searchCountryAndSubtitleForMovieByTerm(byTerm: String, remoteHandler:@escaping([Movie]?)->Void) {
    
        remoteService.searchCountry(byTerm: byTerm) { movie in
            
            if let movie = movie {
                
                 if let movieManaged = self.getMovieById(id: movie[0]["id"]! as! String, favorite: false){
                    self.updateMovieWithSubtitles(movieDict: movie[0], movie: movieManaged)
                }
                
               
                var modelMovies = [Movie]()
                
                let dataLanguages = NSKeyedArchiver.archivedData(withRootObject: movie[0]["languages"]!)
                let dataSubtitles = NSKeyedArchiver.archivedData(withRootObject: movie[0]["subtitles"]!)
                let dataCountries = NSKeyedArchiver.archivedData(withRootObject: movie[0]["countries"]!)
                let dataFlagNames = NSKeyedArchiver.archivedData(withRootObject: movie[0]["flagNames"]!)
               
                let modelMovie = Movie(id: movie[0]["id"] as! String?, title: movie[0]["title"] as! String?, order: nil, summary: movie[0]["summary"] as! String?, imdbRating: movie[0]["imdbRating"] as! String?, category: movie[0]["category"] as! String?, image: movie[0]["image"] as! String?, languages: dataLanguages, subtitles: dataSubtitles, country: movie[0]["country"] as! String?, emissionCountry:dataCountries, flagCountries: dataFlagNames )
                
                modelMovies.append(modelMovie)
                remoteHandler(modelMovies)
            }else{
                print("Error bringing REST Movies")
                remoteHandler(nil)
            }
        }
    }
    
    func getTopMovies(arguments: String, localHandler: @escaping ([Movie]?)->Void, remoteHandler: @escaping ([Movie]?) ->Void)  {
        
        localHandler(self.queryTopMovies())
        
    
        
        remoteService.getTopSeries(arguments: arguments) { movies in
            
            if let movies = movies {
                
                self.markAllObjectsUnsync()
                
                var order = 1
                
                for movieDict in movies {

                    if let movie = self.getMovieById(id: movieDict["id"]! , favorite: false){
                      
                       self.updateMovie(movieDict: movieDict , order: order, movie: movie)
                        
                    }else{
                      
                        self.insertMovie(movieDict: movieDict , order: order)
                    }
                order += 1
                }
                
                self.removeAllNotFavoriteMovies()
                
                
                remoteHandler(self.queryTopMovies())
                
            }else{
                print("Nothing to show")
                remoteHandler(nil)
            }
        }
    }

    
    func queryTopMovies() -> [Movie]? {
        
        let context = stack.persistentContainer.viewContext
        let request : NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "favorite=\(false)")
        request.predicate = predicate
        
        do{
            let fetchedMovies = try context.fetch(request)
            
            var movies = [Movie]()
            
            for managedMovie in fetchedMovies {
                
                movies.append(managedMovie.mappedObject())
            }
            return movies
        }
        catch{
            print("error getting movies from Corde Data")
            return nil
        }
    }
    
    func markAllObjectsUnsync() {
        
        let context = stack.persistentContainer.viewContext
        let request : NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
        
        let predicate = NSPredicate(format: "favorite=\(false)")
        request.predicate = predicate
        
        do{
            let fetchedMovies = try context.fetch(request)
            
            for managedMovie in fetchedMovies {
                
                managedMovie.sync = false
                try context.save()
            }
            
        }
        catch{
            print("error  updating from Core Data")
            
        }
        
        
    }
    
    func getMovieById(id: String, favorite: Bool) -> MovieManaged? {
        
        let context = stack.persistentContainer.viewContext
        let request : NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
        
        let predicate = NSPredicate(format: "id = \(id) and favorite = \(favorite)")
        request.predicate = predicate
        
        do {
            let fetchedMovies = try context.fetch(request)
            
            if fetchedMovies.count > 0 {
                return fetchedMovies.last
            }else{
                return nil
            }
            
        }
        catch {
            print("error getting data from Core Data")
            return nil
        }
    }
    
    func insertMovie(movieDict: [String: String], order: Int) {
        
        let context = stack.persistentContainer.viewContext
        let movie = MovieManaged(context: context)
        
        movie.id = movieDict["id"]
        
        updateMovie(movieDict: movieDict, order: order, movie: movie)
        
    }
    
    func updateMovieWithSubtitles(movieDict: [String: AnyObject], movie: MovieManaged) {
        
        let context = stack.persistentContainer.viewContext
        
        
        movie.title = movieDict["title"] as! String?
        movie.summary = movieDict["summary"] as! String?
        movie.image = movieDict["image"] as! String?
        movie.category = movieDict["category"] as! String?
        movie.imdbRating = movieDict["imdbRating"] as! String?
        movie.country = movieDict["country"] as! String?
        
        let arrayCountries = movieDict["countries"]
        let data = NSKeyedArchiver.archivedData(withRootObject: arrayCountries!)
        movie.emissionCountries = data as NSData?
        
        let arrayItemLanguage = movieDict["languages"]
        let dataForLanguages = NSKeyedArchiver.archivedData(withRootObject: arrayItemLanguage!)
        movie.language = dataForLanguages as NSData?
        
        let arraySubtitles = movieDict["subtitles"]
        let dataForSubtitles = NSKeyedArchiver.archivedData(withRootObject: arraySubtitles!)
        movie.subtitle = dataForSubtitles as NSData?
        
        
        let flagNames = movieDict["flagNames"]
        let dataForFlagNames =  NSKeyedArchiver.archivedData(withRootObject: flagNames!)
        movie.flagCountries = dataForFlagNames as NSData?
        
        movie.sync = true
        
        do {
            try context.save()
        }catch{
            print("Error updating data")
        }
    }
    
    
    func updateMovie(movieDict: [String: String], order: Int, movie: MovieManaged) {
        
        let context = stack.persistentContainer.viewContext
        
        movie.order = Int16(order)
        movie.title = movieDict["title"]
        movie.summary = movieDict["summary"]
        movie.image = movieDict["image"]
        movie.category = movieDict["category"]
        movie.imdbRating = movieDict["imdbRating"]
        movie.sync = true
        
        
        do {
            try context.save()
        }catch{
            print("Error updating data")
        }
    }
    
    func  removeAllNotFavoriteMovies() {
        
        let context = stack.persistentContainer.viewContext
        let request : NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
        
        let predicate = NSPredicate(format: "favorite = \(false)")
        request.predicate = predicate
        
        do {
            let fetchedMovies = try context.fetch(request)
            
            for fetchedMovie in fetchedMovies {
                
                if !fetchedMovie.sync {
                    
                    context.delete(fetchedMovie)
                }
                
                try context.save()
            }
        }catch{
            print("Error delting from Core Data")
        }
    }
    
    func getFavoriteMovies() ->[Movie]? {
        
        let context = stack.persistentContainer.viewContext
        let request : NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
        
        let predicate = NSPredicate(format: "favorite = \(true)")
        request.predicate = predicate
        
        do {
            let fetchedMovies = try context.fetch(request)
            
            var  movies: [Movie] = [Movie]()
            
            for managedMovie in fetchedMovies{
                movies.append(managedMovie.mappedObject())
            }
            return movies
            
        }catch{
            print("Error getting favorites")
            return nil
        }
    }
    
    func isMovieFavorite (movie: Movie) ->Bool {
        
        if let _ = getMovieById(id: movie.id!, favorite: true) {
            
            return true
        }else{
            return false
        }
    }
    
    
    func markUnmarkfavorite(movie: Movie) {
        
        let context = stack.persistentContainer.viewContext
        
        if let exist = getMovieById(id: movie.id!, favorite: true){
            
            context.delete(exist)
            
        }else{
            
            let favorite = MovieManaged(context: context)
            
            favorite.id = movie.id
            favorite.title = movie.title
            favorite.imdbRating = movie.imdbRating
            favorite.summary = movie.summary
            favorite.image = movie.image
            favorite.favorite = true
            
            
            do {
                try context.save()
                
            }catch {
                print("Errir saving context")
            }
        }
        
        updateFavoritesBadge()
    }
    
    func updateFavoritesBadge(){
     
        if let totalFavorites = getFavoriteMovies()?.count{
            
            let notification = Notification(name: Notification.Name("updateFavoritesBadgeNotification"), object: totalFavorites, userInfo: nil)
            NotificationCenter.default.post(notification)
        }
    }
}
