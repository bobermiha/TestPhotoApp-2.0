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
//    private let itemPerRow = CGFloat(2)
//    private let sectionInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        congfigureCollectionView()
        setUpSearchBar()
        title = "Photos"
        //        setUpNavigationController()
    }
    
    
    // MARK: SetUp UI
    
    private func congfigureCollectionView() {
        self.collectionView!.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseID)
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        
        if let watefallLayut = collectionViewLayout as? WaterfallLayout {
            watefallLayut.delegate = self
        }
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionViewCell
        guard let imageData = cell.photo else { return }
        let detailVC = DetailViewController()
        detailVC.photo = imageData
        navigationController?.pushViewController(detailVC, animated: true)
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
//
//extension FirstViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let photo = photos[indexPath.item]
//        let paddingSpace = sectionInsets.left * (itemPerRow + 1)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemPerRow
//        let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
//        return CGSize(width: widthPerItem, height: height)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.right
//    }
//}

extension FirstViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let photo = photos[indexPath.item]
        //        print("photo.width: \(photo.width) photo.height: \(photo.height)\n")
        return CGSize(width: photo.width, height: photo.height)
    }
}
