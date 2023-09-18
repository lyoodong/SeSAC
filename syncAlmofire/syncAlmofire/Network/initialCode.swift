//
//  initialCode.swift
//  syncAlmofire
//
//  Created by Dongwan Ryoo on 2023/09/17.
//

import Foundation
//
//class APIManager2 {
//    
//    static let shared = APIManager2()
//
//    private init() { }
//    
//    func syncRequest(searchText: String,completion: @escaping (Result?, Error?) -> Void ) {
//        callRequest(query: searchText, completion: completion)
//    }
//    
//    func callRequest(query:String, completion: @escaping (Result?, Error?) ->Void) {
//        
//        guard let encodeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
//        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(encodeQuery)&display=30"
//        let headers:HTTPHeaders = [
//            "X-Naver-Client-Id":APIkey.clientID,
//            "X-Naver-Client-Secret":APIkey.clientSecret
//        ]
//        
//        print(url, query)
//        AF.request(url, headers: headers).validate().responseDecodable(of: Result.self){ response in
//            switch response.result {
//            case .success(let value):
//                print("APIManager request 성공", query)
//                completion(value, nil)
//                
//            case .failure(let error):
//                print("APIManager request 실패", query)
//                completion(nil, error)
//                
//            }
//        }
//    }
//}
