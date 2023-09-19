//
//  APIManager.swift
//  BearAPIAbstraction
//
//  Created by Dongwan Ryoo on 2023/09/19.
//

import Foundation
import Alamofire

class BeerAPIManager {
    
    static let shared = BeerAPIManager()
    private init() { }

    func getBeers(completion: @escaping ([Beer]) -> Void) {
        
        let api = BeerAPI.getBeers
        
        AF.request(api.endPoint, method: .get).responseDecodable(of: [Beer].self) { response in
            
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSingleBeer(id: String, completion: @escaping ([Beer]) -> Void) {
        
        let api = BeerAPI.getSingleBeer(id: id)
        
        AF.request(api.endPoint, method: .get).responseDecodable(of: [Beer].self) { response in
            
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRandomBeer(completion: @escaping ([Beer]) -> Void) {
        
        let api = BeerAPI.getRandomBeer
        
        AF.request(api.endPoint, method: .get).responseDecodable(of: [Beer].self) { response in
            
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
