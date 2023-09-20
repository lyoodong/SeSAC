//
//  Router.swift
//  BearAPIAbstraction
//
//  Created by Dongwan Ryoo on 2023/09/20.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case getBeers
    case getRandomBeer
    case getSingleBeer(id: String) //연관값.
    
    private var BaseURL: URL {
        return URL(string: "https://api.punkapi.com/v2/beers")!
    }
    
    var path: String {
        switch self {
        case .getBeers:
            return ""
        case .getRandomBeer:
            return "/random"
        case .getSingleBeer(let id):
            return "/\(id)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = BaseURL.appendingPathComponent(path)
        let request = URLRequest(url: url)
        
        return request
    }

}


////수업 예시 header나 parameter는 필요하면 추가
//enum Router: URLRequestConvertible {
//
//    private static let key = "TCLEecqFutJKTu8ZzlDB41J_Qt6x2HdBGMtNnzCYzwk"
//
//    case search(query: String)
//    case random
//    case detail(id: String)
//
//    private var baseURL: URL {
//        return URL(string: "https://api.unsplash.com/")!
//    }
//
//    //endpoint가 다른 파일에서 호출될 이유가 없으니 private으로 접근 제어를 해줘라.
//    private var path: String {
//        switch self {
//        case .search:
//            return "search/photos"
//        case .random:
//            return "photos/random"
//        case .detail(let id):
//            return "photos/\(id)"
//        }
//    }
//
//    var header: HTTPHeaders {
//        return ["Authorization" : "Client-ID \(Router.key)"]
//    }
//
//    var method: HTTPMethod {
//        switch self {
//        case .search:
//            return .get
//        case .random:
//            return .get
//        case .detail(let id):
//            return .get
//        }
//    }
//
//    var query: [String: String] {
//        switch self {
//        case .search(let query):
//            return ["query" : query]
//        case .random, .detail:
//            return ["" : ""]
//        }
//    }
//
//    func asURLRequest() throws -> URLRequest {
//
//        let url = baseURL.appendingPathComponent(path)
//        var request = URLRequest(url: url)
//
//        request.headers = header
//        request.method = method
//
//        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request)
//
//        return request
//    }
//}
