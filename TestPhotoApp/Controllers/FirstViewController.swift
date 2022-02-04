//
//  MainCollectionViewController.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 01.02.2022.
//

import UIKit


class FirstViewController: UICollectionViewController {
    
    private var nerworkDataManager = NetworkDataManager()
    private var timer: Timer?
    private var photos = [PhotoData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .yellow
        registerCell()
        setUpSearchBar()
        title = "Photos"
        //        setUpNavigationController()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
    }
    
    
    // MARK: SetUp UI
    
    private func registerCell() {
        self.collectionView!.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseID)
    }
    
    private func setUpSearchBar(){
        let searchConroller = UISearchController(searchResultsController: nil)
        searchConroller.searchBar.placeholder = "Search photo"
        searchConroller.obscuresBackgroundDuringPresentation = false
        //        searchConroller.searchResultsUpdater = self
        searchConroller.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchConroller
    }
    
    //    private func setUpNavigationController() {
    //        let navigationApearance = UINavigationBarAppearance()
    //        navigationApearance.configureWithOpaqueBackground()
    //        navigationApearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    //        navigationApearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    //
    //        navigationApearance.backgroundColor = UIColor(
    //            red: 21/255,
    //            green: 101/255,
    //            blue: 191/255,
    //            alpha: 194/255
    //        )
    //
    //        navigationController?.navigationBar.standardAppearance = navigationApearance
    //        navigationController?.navigationBar.scrollEdgeAppearance = navigationApearance
    //        navigationController?.navigationBar.tintColor = .white
    //    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseID, for: indexPath) as! PhotosCollectionViewCell
        let photo = photos[indexPath.item]
        cell.photo = photo
        return cell
    }
}


// MARK: UISearchBarDelegate

extension FirstViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.nerworkDataManager.fetchImages(searchKeyWord: searchText) { [weak self] data in
                guard let data = data else { return }
                self?.photos = data.results
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        })
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension FirstViewController: UICollectionViewDelegateFlowLayout {
}
