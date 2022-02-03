//
//  MainCollectionViewController.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 01.02.2022.
//

import UIKit

private let reuseIdentifier = "PhotoItem"

class FirstViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.backgroundColor = .white
        registerCell()
        setUpSearchBar()
//        setUpNavigationController()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        

    }
    
    
    // MARK: SetUp UI
    
    private func registerCell() {
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func setUpSearchBar(){
        let searchConroller = UISearchController(searchResultsController: nil)
        searchConroller.searchBar.placeholder = "Search photo"
        searchConroller.obscuresBackgroundDuringPresentation = false
//        searchConroller.searchResultsUpdater = self
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        cell.backgroundColor = .green
        return cell
    }

    

}
