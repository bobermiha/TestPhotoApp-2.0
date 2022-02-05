//
//  DetailViewController.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 01.02.2022.
//

import UIKit
import Foundation
import RealmSwift
import SwiftUI

class DetailViewController: UIViewController {
    
    let realm = try! Realm()
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    var photo: PhotoData! {
        didSet {
            let photoUrl = photo.urls["regular"]
            guard let imageURL = photoUrl, let url = URL(string: imageURL) else { return }
            imageView.sd_setImage(with: url, completed: nil)
            usernameLabel.text = "By: \(photo.user.username)"
            createdAtLabel.text = "created at: \(dateFormatter.string(from: photo.createdAt))"
        }
    }
    
    private var imageView: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.backgroundColor = UIColor(red: 255 / 255, green: 249 / 255, blue: 249 / 255, alpha: 1.0)
        photo.contentMode = .scaleToFill
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
    
    private var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUPImageView()
        setUpCreatedAtLabel()
        setUpButton()
        setUpUsernameLabel()
        updateButtonImage()
    }
    
    @objc private func likeButtonPressed() {
        photo.isFavourite.toggle()
        updateButtonImage()
        let favouritePhoto = FavouritePhoto()
        favouritePhoto.userName = photo.user.username
        favouritePhoto.createdAT = dateFormatter.string(from: photo.createdAt)
        favouritePhoto.photoUrl = photo.urls["regular"]!
        if photo.isFavourite {
            saveObject(photo: favouritePhoto)
        } else {
            deleteObject(photo: favouritePhoto)
        }
    }
    
    // MARK: RealmMethods
    
    private func saveObject(photo: FavouritePhoto) {
        do {
            try self.realm.write({
                self.realm.add(photo)
            })
            presentSuccessSaveAlert()
        } catch {
            print(error.localizedDescription)
            presentUnsuccsessSaveAlert()
        }
    }
    
    private func deleteObject(photo: FavouritePhoto) {
        let predicate = NSPredicate(format: "photoUrl=%@", photo.photoUrl)
        do{
            try realm.write({
                realm.delete(realm.objects(FavouritePhoto.self).filter(predicate))
            })
            presentSuccessDeleteAlert()
        }catch let error {
            print(error.localizedDescription)
            presentUnsuccsessDeleteAlert()
        }
    }
    
    // MARK: Allert Methods
    private func presentSuccessSaveAlert() {
        let allertController = UIAlertController(title: "Photo was saved", message: "Your photo has been succesfully saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        allertController.addAction(okAction)
        present(allertController, animated: true, completion: nil)
    }
    
    private func presentUnsuccsessSaveAlert() {
        let allertController = UIAlertController(title: "Photo was not saved", message: "Something went wrong", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        allertController.addAction(okAction)
        present(allertController, animated: true, completion: nil)
    }
    
    private func presentSuccessDeleteAlert() {
        let allertController = UIAlertController(title: "Photo was deleted", message: "Your photo has been succesfully deleted", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        allertController.addAction(okAction)
        present(allertController, animated: true, completion: nil)
    }
    
    private func presentUnsuccsessDeleteAlert() {
        let allertController = UIAlertController(title: "Photo was not deleted", message: "Something went wrong", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        allertController.addAction(okAction)
        present(allertController, animated: true, completion: nil)
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
    
    private func setUpButton() {
        view.addSubview(likeButton)
        likeButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        likeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        likeButton.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 15).isActive = true
    }
    
    private func updateButtonImage(){
        let imageName = photo.isFavourite ? "heart.fill" : "heart"
        let buttonImage = UIImage(systemName: imageName)
        likeButton.setBackgroundImage(buttonImage, for: .normal)
    }
}
