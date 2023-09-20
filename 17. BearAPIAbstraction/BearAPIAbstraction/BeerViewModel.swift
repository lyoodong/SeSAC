//
//  BeerViewModel.swift
//  BearAPIAbstraction
//
//  Created by Dongwan Ryoo on 2023/09/20.
//

import Foundation
import Alamofire

class BeerViewModel {
    
    let api = Network.shared
    
    func request(completion: @escaping (URL) -> Void) {
        
        api.requestRouter(type: [Beer].self, api: .getRandomBeer) { response in
            switch response {
            case.success(let value):
                guard let url = URL(string: value[0].imageURL ?? "") else { return }
                completion(url)
        
            case.failure(let error):
                print(error)
            }
        }
    }
}
