//
//  Model.swift
//  LotteryAppByMVVM
//
//  Created by Dongwan Ryoo on 2023/09/13.
//

import Foundation

struct Result: Codable {
    let drwtNo6, drwtNo3, drwtNo1, drwtNo4: Int
    let drwNo, firstAccumamnt: Int
    let returnValue: String
    let firstPrzwnerCo, totSellamnt, drwtNo5, drwtNo2: Int
    let drwNoDate: String
    let bnusNo, firstWinamnt: Int
}
