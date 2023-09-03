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
    
    enum VideoType {
        case movie
        case tv
        case person
    }
    
    //영화 호출
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
                : print("callRequestCadableCast", error)
            }
        }
    }
    
    //URL 세션 활용
    func callRequestCodable(videoType: VideoType, completionHandler: @escaping (TMDBData) -> Void) {
        let urlString = "https://api.themoviedb.org/3/trending/\(videoType)/week?api_key=\(APIKey.key)"
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let tmdbData = try decoder.decode(TMDBData.self, from: data)
                    print(tmdbData)
                    completionHandler(tmdbData)
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
    }
    
    //추천 영화 호출
    func callRequestCadableRecommendation(_ id:Int, complitenHandler :@escaping (TMDBData)->Void){
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(APIKey.key)"
        
        AF.request(url).validate().responseDecodable(of:TMDBData.self) { response in
            switch response.result {
            case.success(let value)
                : complitenHandler(value)
                
            case.failure(let error)
                :print("callRequestCadableRecommendation", error)
            }
        }
    }

}
