//
//  MovieViewController.swift
//  iTunesClientApp
//
//  Created by Furkan Ademoğlu on 7.10.2022.
//

import UIKit

class MovieViewController: UIViewController {
    
    // MARK: - Properties
    private let mainView = MainView()
    private let networkService = BaseNetworkService()
    private var movieResponse: MovieResponse? {
        didSet {
            mainView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        view = mainView
        mainView.setCollectionViewDelegate(self, andDataSource: self)
        
        let searchController = UISearchController()
                searchController.searchBar.placeholder = "Education, Fun..."
                searchController.searchResultsUpdater = self
                navigationItem.searchController = searchController
        fetchPodcasts()
    }
    
    // MARK: - Methods
        private func fetchPodcasts(with text: String = "Music") {
            networkService.request(MovieRequest(searchText: text)) { result in
                switch result {
                case .success(let response):
                    self.movieResponse = response
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }
        }
}

// MARK: - UICollectionViewDelegate
extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.movie = movieResponse?.results?[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieResponse?.results?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PodcastCollectionViewCell
        let music = movieResponse?.results?[indexPath.row]
        cell.title = music?.trackName
        cell.imageView.downloadImage(from: music?.artworkLarge)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}
// MARK: - UISearchResultsUpdating
extension MovieViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchPodcasts(with: text)
        }
    }
}
