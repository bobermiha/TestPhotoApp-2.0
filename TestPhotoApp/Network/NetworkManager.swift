//
//  NetworkManager.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 03.02.2022.
//

import Foundation

class NetworkManager {
    
    func request(searchWord: String, comletion: (Data?, Error?) -> Void) {
        
        let parameters = generateParameters(searchWord: searchWord)
        let url = generateUrl(parameters: parameters)
        
    }
    
    
    private func generateParameters(searchWord: String?) -> [String: String]{
        var parameters = [String : String]()
        parameters["query"] = searchWord
        parameters["page"] = String(1)
        parameters["per_page"] = String(45)
        return parameters
    }
    
    private func generateUrl(parameters: [String: String]) -> URL {
        var componets = URLComponents()
        componets.scheme = "https"
        componets.host = "api.unsplash.com"
        componets.path = "/search/photos"
        componets.queryItems = parameters.map {URLQueryItem(name: $0, value: $1)}
        return componets.url!
    }
    
}
