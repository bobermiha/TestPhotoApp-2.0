//
//  DetailViewController.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 01.02.2022.
//

import UIKit
import Foundation

class DetailViewController: UIViewController {
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY/MMM/dd"
        return formatter
    }()
    
    var photo: PhotoData! {
        didSet {
            let photoUrl = photo.urls["regular"]
            guard let imageURL = photoUrl, let url = URL(string: imageURL) else { return }
            imageView.sd_setImage(with: url, completed: nil)
            title = "Author: \(photo.user.username)"
            createdAtLabel.text = photo.createdAt
        }
    }
    
    private var imageView: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.backgroundColor = UIColor(red: 255 / 255, green: 249 / 255, blue: 249 / 255, alpha: 1.0)
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    private var createdAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Veranda", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUPImageView()
        setUpCreatedAtLabel()
    }
    
    func setUPImageView() {
        view.addSubview(imageView)
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setUpCreatedAtLabel() {
        view.addSubview(createdAtLabel)
        createdAtLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100).isActive = true
        createdAtLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        createdAtLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        createdAtLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
}
