//
//  BeerAPI.swift
//  BearAPIAbstraction
//
//  Created by Dongwan Ryoo on 2023/09/19.
//

import Foundation

enum BeerAPI {
    
    case getBeers
    case getRandomBeer
    case getSingleBeer(id: String) //연관값.
    
    private var BaseURL: String {
        return "https://api.punkapi.com/v2/beers"
    }
    
    var endPoint: String {
        switch self {
        case .getBeers:
            return BaseURL
        case .getRandomBeer:
            return BaseURL + "/random"
        case .getSingleBeer(let id):
            return BaseURL + id
        }
    }

}
