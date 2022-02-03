//
//  PhotosModel.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 03.02.2022.
//

import Foundation

struct RequestResults: Codable {
    let total: Int
    let results: [PhotosData]
}

struct PhotosData: Codable {
    let height: Int
    let width: Int
    let createdAt: Date
    let urls: [URLTypes.RawValue : String]
    let user: User
    
    
    enum URLTypes: String {
        case raw, full, regular, thumb, small
    }
    
    enum CodingKeys: String, CodingKey {
        case height, width
        case createdAt = "created_at"
        case user
        case urls
    }
}

struct User: Codable {
    let username: String
}
