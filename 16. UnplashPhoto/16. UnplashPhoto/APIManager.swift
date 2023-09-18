//
//  APIManager.swift
//  16. UnplashPhoto
//
//  Created by Dongwan Ryoo on 2023/09/18.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    private let key = "TCLEecqFutJKTu8ZzlDB41J_Qt6x2HdBGMtNnzCYzwk"
    
    private init() { }
    
    func searchPhoto(completion: @escaping (Results?) -> Void ) {
    
        guard let url = URL(string: "https://api.unsplash.com/photos/random/?client_id=\(key)") else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Results.self, from: data!)
                completion(result)
                
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
}
