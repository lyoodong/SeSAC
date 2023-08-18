//
//  Model.swift
//  10. MediaProject
//
//  Created by Dongwan Ryoo on 2023/08/12.
//
import Foundation

// MARK: - CastData
struct CastData: Codable {
    let crew: [Cast]
    let id: Int
    let cast: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let name: String
    let gender: Int
    let order: Int?
    let character: String?
    let popularity: Double
    let castID: Int?
    let knownForDepartment: String
    let id: Int
    let originalName: String
    let adult: Bool
    let creditID: String
    let profilePath: String?
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case name, gender, order, character, popularity
        case castID = "cast_id"
        case knownForDepartment = "known_for_department"
        case id
        case originalName = "original_name"
        case adult
        case creditID = "credit_id"
        case profilePath = "profile_path"
        case department, job
    }
}


// MARK: - TMDBData
struct TMDBData: Codable {
    let totalResults, page, totalPages: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case page
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let releaseDate, backdropPath: String
    let id: Int
    let originalLanguage: String
    let voteCount: Int
    let title: String
    let popularity: Double
    let posterPath: String
    let video: Bool
    let voteAverage: Double
    let genreIDS: [Int]
    let originalTitle, mediaType, overview: String
    let adult: Bool

    enum CodingKeys: String, CodingKey {
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case title, popularity
        case posterPath = "poster_path"
        case video
        case voteAverage = "vote_average"
        case genreIDS = "genre_ids"
        case originalTitle = "original_title"
        case mediaType = "media_type"
        case overview, adult
    }
}
