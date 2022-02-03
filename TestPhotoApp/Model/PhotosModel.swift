//
//  PhotosModel.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 03.02.2022.
//

import Foundation

struct RequestResuls: Codable {
    let total: Int
    let results: [PhotosData]
}

struct PhotosData: Codable {

       let createdAt: Date?
       let width: Int?
       let height: Int?
       let user: User
       let urls: Urls

       enum CodingKeys: String, CodingKey {
           case createdAt = "created_at"
           case width, height
           case user
           case urls
       }
}

struct User: Codable {
    let username: String
}

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}
