//
//  PhotosCollectionViewCell.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 04.02.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "PhotoItem"
    var photo: PhotoData! {
        didSet {
            let photoUrl = photo.urls["regular"]
        }
    }
    
    private let imageView: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.backgroundColor = UIColor(red: 255 / 255, green: 249 / 255, blue: 249 / 255, alpha: 1.0)
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    private func configurateConstraints() {
        addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}