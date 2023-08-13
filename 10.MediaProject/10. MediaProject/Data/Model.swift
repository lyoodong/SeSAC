//
//  Model.swift
//  10. MediaProject
//
//  Created by Dongwan Ryoo on 2023/08/12.
//

import Foundation

struct Movie {
    let id:Int
    let backdropPath: String
    let title: String
    let overview:String
    let posterPath: String
    let releaseDate: String
    let voteAverage: Double
}


struct Cast {
    let originalName: String
    let profilePath: String
}
