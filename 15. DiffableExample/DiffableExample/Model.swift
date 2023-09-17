//
//  Model.swift
//  DiffableExample
//
//  Created by Dongwan Ryoo on 2023/09/17.
//

import UIKit

struct Model: Hashable {
    let title: String
    let imageName: String
    let image: UIImage?
    let id = UUID().uuidString
    
    init(title: String, imageName:String) {
        self.title = title
        self.imageName = imageName
        self.image = UIImage(systemName: self.imageName)
    }
}

enum SettingOptions:Int, CaseIterable {
    case total, personal, others
    
    var mainOption:String {
        switch self {
        case .total: return "전체 설정"
        case .personal: return "개인 설정"
        case .others: return "기타 설정"
        }
    }
    
    var subOptions:[String]{
        switch self {
        case .total: return ["공지사항", "실험실", "버전 정보"]
        case .personal: return ["개인보안", "알림", "채팅", "멀티프로필"]
        case .others: return ["고객센터/도움말"]
        }
        
    }
    
}
