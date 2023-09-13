//
//  APIManager.swift
//  LotteryAppByMVVM
//
//  Created by Dongwan Ryoo on 2023/09/13.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    private init() { }
    
    func callRequest(num: Int, completion: @escaping (Result) -> Void) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(num)"

        AF.request(url, method: .get).validate().responseDecodable(of: Result.self) { result in
            switch result.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}


