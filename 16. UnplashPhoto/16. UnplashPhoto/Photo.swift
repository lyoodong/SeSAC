//
//  Photo.swift
//  16. UnplashPhoto
//
//  Created by Dongwan Ryoo on 2023/09/18.
//

import Foundation

struct Results: Codable {
    let urls: Urls
}

struct Urls: Codable {
    let regular, thumb, small, full, smallS3, raw: String

    enum CodingKeys: String, CodingKey {
        case regular, thumb, small, full
        case smallS3 = "small_s3"
        case raw
    }
}
