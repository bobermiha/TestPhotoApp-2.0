//
//  MainViewController.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 02.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstViewController = FirstViewController(collectionViewLayout: WaterfallLayout())
        let secondViewConroller = SecondTableViewController()
        
        viewControllers = [
            setUpNavigationController(title: "Photos",
                                      image: UIImage(systemName: "photo.on.rectangle.angled"),
                                      rootViewController: firstViewController),
            setUpNavigationController(title: "Favourites",
                                      image: UIImage(systemName: "heart.fill"),
                                      rootViewController: secondViewConroller)
        ]
    }
    
    private func setUpNavigationController(title: String, image: UIImage?, rootViewController: UIViewController) -> UIViewController {
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.tabBarItem.image = image
        navigationViewController.tabBarItem.title = title
        return navigationViewController
    }
}


