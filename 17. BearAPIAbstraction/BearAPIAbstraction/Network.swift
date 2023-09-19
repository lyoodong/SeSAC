//
//  Netwokr.swift
//  BearAPIAbstraction
//
//  Created by Dongwan Ryoo on 2023/09/19.
//

import Foundation
import Alamofire

class Network{
    
    private static let shared = Network()
    private init() { }

    func request<T: Decodable>(type: T.Type, api:BeerAPI, completion:@escaping (Result<T, BeerError>)-> Void) {
        
        AF.request(api.endPoint, method: .get).responseDecodable(of: type.self) { response in
            
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
