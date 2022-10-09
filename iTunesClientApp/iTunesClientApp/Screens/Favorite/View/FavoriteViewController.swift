//
//  FavoriteViewController.swift
//  iTunesClientApp
//
//  Created by Furkan Ademoğlu on 9.10.2022.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    // MARK: - Properties
    var favoriteItems : [NSManagedObject] = []
    private let mainView = MainView()
    private var podcastResponse: PodcastResponse? {
        didSet {
            mainView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorities"
        view = mainView
        mainView.setCollectionViewDelegate(self, andDataSource: self)
        
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
            print(favoriteItems)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

// MARK: - UICollectionViewDelegate
extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.podcast = podcastResponse?.results?[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PodcastCollectionViewCell
        let favoriteItem = favoriteItems[indexPath.row]
        cell.title = favoriteItem.value(forKey: "trackName") as! String?
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}
