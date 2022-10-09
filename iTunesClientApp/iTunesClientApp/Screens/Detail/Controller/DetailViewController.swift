//
//  DetailViewController.swift
//  iTunesClientApp
//
//  Created by Furkan Ademoğlu on 6.10.2022.
//

import UIKit
import CoreData

final class DetailViewController: UIViewController {
    
    
    var favoriteItems : [NSManagedObject] = []
    var podcast: Podcast? {
          didSet {
              title = podcast?.trackName
              detailView.imageView.downloadImage(from: podcast?.artworkLarge)
              detailView.releaseDate = podcast?.releaseDate
              detailView.artistName = podcast?.artistName
              detailView.country = podcast?.country
              detailView.genres = podcast?.genres?.reduce("") { $1 + ", " + $0 }
          }
      }
    
    var music: Music? {
          didSet {
              title = music?.trackName
              detailView.imageView.downloadImage(from: music?.artworkLarge)
              detailView.releaseDate = music?.releaseDate
              detailView.artistName = music?.artistName
              detailView.country = music?.country
              detailView.genres = music?.genres?.reduce("") { $1 + ", " + $0 }
          }
      }
    
    var movie: Movie? {
          didSet {
              title = movie?.trackName
              detailView.imageView.downloadImage(from: movie?.artworkLarge)
              detailView.releaseDate = movie?.releaseDate
              detailView.artistName = movie?.artistName
              detailView.country = movie?.country
              detailView.genres = movie?.genres?.reduce("") { $1 + ", " + $0 }
          }
      }
    
    var software: Software? {
          didSet {
              title = software?.trackName
              detailView.imageView.downloadImage(from: software?.artworkLarge)
              detailView.releaseDate = software?.releaseDate
              detailView.artistName = software?.artistName
              detailView.country = software?.country
              detailView.genres = software?.genres?.reduce("") { $1 + ", " + $0 }
          }
      }
      
      private let detailView = DetailView()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          view = detailView
          detailView.button.addTarget(self, action: #selector(save), for: .touchUpInside)
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "FavoriteItem")
        
        //3
        do {
          favoriteItems = try managedContext.fetch(fetchRequest)
            for favoriteItem in favoriteItems {
                if ((favoriteItem.value(forKey: "trackName") as! String) == title){
                    detailView.button.setTitle("Added To Favorities", for: .normal)
                }else{
                    detailView.button.setTitle("Add To Favorities", for: .normal)
                }
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
   @objc func save(sender: UIButton!) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "FavoriteItem",
                                   in: managedContext)!
      
      let item = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
        item.setValue(title, forKeyPath: "trackName")
        item.setValue(detailView.releaseDate, forKeyPath: "releaseDate")
        item.setValue(detailView.country, forKeyPath: "country")
        item.setValue(detailView.artistName, forKeyPath: "artistName")
       detailView.button.setTitle("Added To Favorities", for: .normal)
      // 4
      do {
        try managedContext.save()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
}
