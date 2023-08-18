//
//  APIManager.swift
//  10. MediaProject
//
//  Created by Dongwan Ryoo on 2023/08/18.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    private init() { }
    
    func callRequestCodableMovie(complitionHandler: @escaping (TMDBData)->Void) {
        
        let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(APIKey.key)"
        
        AF.request(url).validate().responseDecodable(of:TMDBData.self) { response in
            switch response.result {
            case.success(let value):
                print(value)
                complitionHandler(value)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func callRequestCadableCast(_ id:Int, complitionHandler: @escaping (CastData) -> Void ) {
    
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(APIKey.key)"
        
        AF.request(url).validate().responseDecodable(of: CastData.self) { respose in
            switch respose.result {
            case .success(let value)
                :complitionHandler(value)
            case .failure(let error)
                : print(error)
            }
        }
    }

}
