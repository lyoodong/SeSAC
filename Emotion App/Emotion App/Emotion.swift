//
//  Emotion.swift
//  Emotion App
//
//  Created by Dongwan Ryoo on 2023/07/26.
//
import UIKit

//
public let zeroDefualt = 0
public let userDefualt =  UserDefaults.standard

//button의 tag와 rawValue가 대응되도록 enum 타입 구성
enum Emotion:Int, CaseIterable {
    case happy
    case good
    case just
    case soso
    case angry
}
