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
            return BaseURL + "/\(id)"
        }
    }

}


enum BeerError: Int, Error {
    case unauthorized = 401
    case permissionDenined = 403
    case invaildServer = 500
    case missingParameter = 400
    
    var errorDescription: String{
        switch self {
        case .unauthorized:
            return "인증정보가 없습니다."
        case .permissionDenined:
            return "권한이 없습니다."
        case .invaildServer:
            return "서버 점검 중입니다"
        case .missingParameter:
            return "검색어를 입력해주세요."
        }
    }
}
