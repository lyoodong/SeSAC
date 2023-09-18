//
//  APIManager.swift
//  syncAlmofire
//
//  Created by Dongwan Ryoo on 2023/09/17.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    private var requestQueue = [String]()
    private var isRequesting = false
    
    private init() { }
    
    func syncRequest(searchText: String,completion: @escaping (Result?, Error?) -> Void ) {
        requestQueue.append(searchText)
        if !isRequesting {
            print(searchText, "API 호출 실행")
            callRequest(completion: completion)
        }
    }
    
    func callRequest(completion: @escaping (Result?, Error?) ->Void) {
        
        guard let query = requestQueue.first else { isRequesting = false
            return }
        print(#function, requestQueue)
        isRequesting = true
        
        guard let encodeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(encodeQuery)&display=30"
        let headers:HTTPHeaders = [
            "X-Naver-Client-Id":APIkey.clientID,
            "X-Naver-Client-Secret":APIkey.clientSecret
        ]
        
        print(url, query)
        AF.request(url, headers: headers).validate().responseDecodable(of: Result.self){ response in
            self.requestQueue.removeFirst()
            switch response.result {
            case .success(let value):
                print("APIManager request 성공", query)
                completion(value, nil)
                
            case .failure(let error):
                print("APIManager request 실패", query)
                completion(nil, error)
                
            }
            self.callRequest(completion: completion)
        }
    }
}
