//
//  APIManager.swift
//  BearAPIAbstraction
//
//  Created by Dongwan Ryoo on 2023/09/19.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    private init() { }
    
    func getBeers(completion: @escaping ([Beer]) -> Void) {
        
        let url = "https://api.punkapi.com/v2/beers"
        
        AF.request(url, method: .get).responseDecodable(of: [Beer].self) { response in
            
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSingleBeers(id: String, completion: @escaping ([Beer]) -> Void) {
        
        let url = "https://api.punkapi.com/v2/beers/\(id)"
        
        AF.request(url, method: .get).responseDecodable(of: [Beer].self) { response in
            
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRandomBeers(completion: @escaping ([Beer]) -> Void) {
        
        let url = "https://api.punkapi.com/v2/beers/random"
        
        AF.request(url, method: .get).responseDecodable(of: [Beer].self) { response in
            
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
