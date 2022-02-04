//
//  SecondTableViewController.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 01.02.2022.
//

import UIKit
import RealmSwift

class SecondTableViewController: UITableViewController {

    let ream = try! Realm()
    var photos: Results<FavouritePhoto>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.backgroundColor = .white
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let photos = photos else {return 0}
        return photos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PhotoTableViewCell
        let photo = photos[indexPath.row]
        cell.textLabel?.text = photo.userName
        return cell
    }

}
