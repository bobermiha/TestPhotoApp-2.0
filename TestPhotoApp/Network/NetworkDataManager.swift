//
//  NetworkDataManager.swift
//  TestPhotoApp
//
//  Created by Михаил Бобров on 03.02.2022.
//

import Foundation


class NetworkDataManager {
    
    private var networkRequestManager = NetworkRequestManager()
    
    func fetchImages(searchKeyWord: String, completion: @escaping (PhotosData?) -> ()) {
        networkRequestManager.request(searchKeyWord: searchKeyWord) { (data, error) in
            if let error = error {
                print("Error! Data was not received \(error.localizedDescription)")
                completion(nil)
            }
            let decodedData = self.decodeJSON(type: PhotosData.self, from: data)
            completion(decodedData)
        }
    }
    
    func decodeJSON<T: Codable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let items = try decoder.decode(type.self, from: data)
            return items
        }catch let decodeError {
            print("Decoding was failed", decodeError)
            return nil
        }
    }
}
