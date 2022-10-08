//
//  SoftwareViewController.swift
//  iTunesClientApp
//
//  Created by Furkan Ademoğlu on 8.10.2022.
//

import UIKit

class SoftwareViewController: UIViewController {
    
    // MARK: - Properties
    private let mainView = MainView()
    private let networkService = BaseNetworkService()
    private var softwareResponse: SoftwareResponse? {
        didSet {
            mainView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Softwares"
        view = mainView
        mainView.setCollectionViewDelegate(self, andDataSource: self)
        
        let searchController = UISearchController()
                searchController.searchBar.placeholder = "Education, Fun..."
                searchController.searchResultsUpdater = self
                navigationItem.searchController = searchController
        fetchPodcasts()
    }
    
    // MARK: - Methods
        private func fetchPodcasts(with text: String = "Software") {
            networkService.request(SoftwareRequest(searchText: text)) { result in
                switch result {
                case .success(let response):
                    self.softwareResponse = response
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }
        }
}

// MARK: - UICollectionViewDelegate
extension SoftwareViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.software = softwareResponse?.results?[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension SoftwareViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        softwareResponse?.results?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PodcastCollectionViewCell
        let music = softwareResponse?.results?[indexPath.row]
        cell.title = music?.trackName
        cell.imageView.downloadImage(from: music?.artworkLarge)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}
// MARK: - UISearchResultsUpdating
extension SoftwareViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchPodcasts(with: text)
        }
    }
}

