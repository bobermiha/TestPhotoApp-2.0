//
//  PhotoTableViewCell.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 04.02.2022.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {
    
    static let reuseID = "Cell"
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var photo: FavouritePhoto!{
        didSet {
            guard let photoURL = URL(string: photo.photoUrl) else {return}
            photoImageView.sd_setImage(with: photoURL, completed: nil)
            userNameLabel.text = "Made by: \(photo.userName)"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    private func setUpImageView() {
        addSubview(photoImageView)
        photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setUpLabel() {
        addSubview(userNameLabel)
        userNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 250).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        userNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpImageView()
        setUpLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
