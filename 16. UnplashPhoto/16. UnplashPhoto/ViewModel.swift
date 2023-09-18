//
//  ViewModel.swift
//  16. UnplashPhoto
//
//  Created by Dongwan Ryoo on 2023/09/18.
//

import Foundation

class ViewModel {
    
    var imageLinkType = Observable(String())
    var link = ""
    
    func fetch(_ type: String) {
        
        switch type {
        case ImageLinkType.regular.rawValue:
            fetchRegular()
            
        case ImageLinkType.full.rawValue:
            fetchFull()
            
        case ImageLinkType.raw.rawValue:
            fetchRaw()
            
        case ImageLinkType.small.rawValue:
            fetchSmall()
            
        case ImageLinkType.thumb.rawValue:
            fetchThumb()
            
        default:
            print("에러")
        }
    }
    
    func fetchRegular() {
        APIManager.shared.searchPhoto { Results in
            self.link = Results!.urls.regular
            print(self.link)
        }
    }
    
    func fetchThumb() {
        APIManager.shared.searchPhoto { Results in
            self.link = Results!.urls.thumb
            print(self.link)
        }
    }
    
    func fetchSmall() {
        APIManager.shared.searchPhoto { Results in
            self.link = Results!.urls.small
            print(self.link)
        }
    }
    
    func fetchSmallS3() {
        APIManager.shared.searchPhoto { Results in
            self.link = Results!.urls.smallS3
            print(self.link)
        }
    }
    
    func fetchRaw() {
        APIManager.shared.searchPhoto { Results in
            self.link = Results!.urls.raw
            print(self.link)
        }
    }
    
    func fetchFull() {
        APIManager.shared.searchPhoto { Results in
            self.link = Results!.urls.full
            print(self.link)
        }
    }
}

enum ImageLinkType: String {
    case regular = "regular"
    case thumb = "thumb"
    case small = "small"
    case full = "full"
    case smallS3 = "smallS3"
    case raw = "raw"
}
