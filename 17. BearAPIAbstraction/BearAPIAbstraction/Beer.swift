//
//  Beer.swift
//  BearAPIAbstraction
//
//  Created by Dongwan Ryoo on 2023/09/19.
//

import Foundation

struct Beer: Codable {
    let ph: Double?
    let method: Method
    let targetOg: Double
    let volume: BoilVolume
    let targetFg: Int
    let ibu, attenuationLevel: Double?
    let firstBrewed, description: String?
    let imageURL: String?
    let srm: Double?
    let name: String
    let ebc: Int?
    let tagline: String
    let abv: Double
    let brewersTips: String
    let foodPairing: [String]
    let contributedBy: String?
    let boilVolume: BoilVolume
    let ingredients: Ingredients
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case ph, method
        case targetOg = "target_og"
        case volume
        case attenuationLevel = "attenuation_level"
        case ibu
        case targetFg = "target_fg"
        case firstBrewed = "first_brewed"
        case description
        case imageURL = "image_url"
        case srm, name, ebc, tagline, abv
        case brewersTips = "brewers_tips"
        case foodPairing = "food_pairing"
        case contributedBy = "contributed_by"
        case boilVolume = "boil_volume"
        case ingredients, id
    }
}

// MARK: - BoilVolume
struct BoilVolume: Codable {
    let unit: String
    let value: Double
}

// MARK: - Ingredients
struct Ingredients: Codable {
    let yeast: String
    let hops: [Hop]
    let malt: [Malt]
}

// MARK: - Hop
struct Hop: Codable {
    let attribute, name, add: String
    let amount: BoilVolume
}

// MARK: - Malt
struct Malt: Codable {
    let amount: BoilVolume
    let name: String
}

// MARK: - Method
struct Method: Codable {
    let mashTemp: [MashTemp]
    let twist: String?
    let fermentation: Fermentation
    
    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case twist, fermentation
    }
}

// MARK: - Fermentation
struct Fermentation: Codable {
    let temp: BoilVolume
}

// MARK: - MashTemp
struct MashTemp: Codable {
    let temp: BoilVolume
    let duration: Int?
}
