//
//  Beer.swift
//  BearAPIAbstraction
//
//  Created by Dongwan Ryoo on 2023/09/19.
//

import Foundation

//MARK: - Beer
struct Beer: Codable {
    let contributedBy, firstBrewed: String
    let method: Method
    let ebc, ibu: Int
    let brewersTips, name: String
    let targetOg: Int
    let ingredients: Ingredients
    let foodPairing: [String]
    let imageURL: String
    let id, abv: Int
    let boilVolume: BoilVolume
    let tagline: String
    let attenuationLevel, srm: Int
    let ph: Double
    let description: String
    let targetFg: Int
    let volume: BoilVolume

    enum CodingKeys: String, CodingKey {
        case contributedBy = "contributed_by"
        case firstBrewed = "first_brewed"
        case method, ebc, ibu
        case brewersTips = "brewers_tips"
        case name
        case targetOg = "target_og"
        case ingredients
        case foodPairing = "food_pairing"
        case imageURL = "image_url"
        case id, abv
        case boilVolume = "boil_volume"
        case tagline
        case attenuationLevel = "attenuation_level"
        case srm, ph, description
        case targetFg = "target_fg"
        case volume
    }
}

// MARK: - BoilVolume
struct BoilVolume: Codable {
    let unit: String
    let value: Double
}

// MARK: - Ingredients
struct Ingredients: Codable {
    let malt: [Malt]
    let yeast: String
    let hops: [Hop]
}

// MARK: - Hop
struct Hop: Codable {
    let add: String
    let amount: BoilVolume
    let attribute, name: String
}

// MARK: - Malt
struct Malt: Codable {
    let amount: BoilVolume
    let name: String
}

// MARK: - Method
struct Method: Codable {
    let twist: String
    let mashTemp: [MashTemp]
    let fermentation: Fermentation

    enum CodingKeys: String, CodingKey {
        case twist
        case mashTemp = "mash_temp"
        case fermentation
    }
}

// MARK: - Fermentation
struct Fermentation: Codable {
    let temp: BoilVolume
}

// MARK: - MashTemp
struct MashTemp: Codable {
    let temp: BoilVolume
    let duration: Int
}
