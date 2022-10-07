//
//  DetailViewController.swift
//  iTunesClientApp
//
//  Created by Furkan Ademoğlu on 6.10.2022.
//

import UIKit

final class DetailViewController: UIViewController {

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
              title = music?.trackName
              detailView.imageView.downloadImage(from: music?.artworkLarge)
              detailView.releaseDate = music?.releaseDate
              detailView.artistName = music?.artistName
              detailView.country = music?.country
              detailView.genres = music?.genres?.reduce("") { $1 + ", " + $0 }
          }
      }
      
      private let detailView = DetailView()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          view = detailView
      }
}
