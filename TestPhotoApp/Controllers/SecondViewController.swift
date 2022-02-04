//
//  SecondTableViewController.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 01.02.2022.
//

import UIKit

class SecondTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return cell
    }

}
