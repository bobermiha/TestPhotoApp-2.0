//
//  FavouritePhotoViewController.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 06.02.2022.
//

import UIKit
import RealmSwift

class FavouritePhotoViewController: UIViewController {
    
    var photo: FavouritePhoto!{
        didSet {
            guard let photoURL = URL(string: photo.photoUrl) else {return}
            imageView.sd_setImage(with: photoURL, completed: nil)
            usernameLabel.text = "By: \(photo.userName)"
            createdAtLabel.text = "created at: \(photo.createdAT)"
        }
    }
    
    private var imageView: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.backgroundColor = .white
        photo.contentMode = .scaleAspectFit
        return photo
    }()
    
    private var createdAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 17)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUPImageView()
        setUpCreatedAtLabel()
        setUpUsernameLabel()
    }


    // MARK: UI Configuration methods
    private func setUPImageView() {
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3).isActive = true
        
    }
    
    private func setUpUsernameLabel(){
        view.addSubview(usernameLabel)
        usernameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16).isActive = true
        usernameLabel.widthAnchor.constraint(greaterThanOrEqualTo: imageView.widthAnchor, multiplier: 1/3).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setUpCreatedAtLabel() {
        view.addSubview(createdAtLabel)
        createdAtLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        createdAtLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -15).isActive = true
        createdAtLabel.widthAnchor.constraint(greaterThanOrEqualTo: imageView.widthAnchor, multiplier: 1/3).isActive = true
        createdAtLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
}
