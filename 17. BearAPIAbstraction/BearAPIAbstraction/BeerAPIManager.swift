//
//  APIManager.swift
//  BearAPIAbstraction
//
//  Created by Dongwan Ryoo on 2023/09/19.
//

import Foundation
import Alamofire

final class BeerAPIManager {
    
    static let shared = BeerAPIManager()
    private init() { }

    func getBeers(completion: @escaping (Result<[Beer], BeerError>) -> Void) {
        
        let api = BeerAPI.getBeers
        
        AF.request(api.endPoint, method: .get).responseDecodable(of: [Beer].self) { response in
            
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(_ ):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = BeerError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
    
    func getSingleBeer(id: String, completion: @escaping (Result<[Beer], BeerError>) -> Void) {
        
        let api = BeerAPI.getSingleBeer(id: id)
        
        AF.request(api.endPoint, method: .get).responseDecodable(of: [Beer].self) { response in
            
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(_ ):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = BeerError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
    
    func getRandomBeer(completion: @escaping (Result<[Beer], BeerError>) -> Void) {
        
        let api = BeerAPI.getRandomBeer
        
        AF.request(api.endPoint, method: .get).responseDecodable(of: [Beer].self) { response in
            
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(_ ):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = BeerError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
}
