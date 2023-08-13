//
//  LangType.swift
//  9. PapagoTranslate
//
//  Created by Dongwan Ryoo on 2023/08/10.
//

import Foundation

struct LangType {
    //언어 감지는 되지만, 번역할 수 없는 언어는 주석 처리
    static let langDic: [String: String] = [
        "한국어": "ko",
        "일본어": "ja",
        "중국어 간체": "zh-CN",
        "중국어 번체": "zh-TW",
//        "힌디어": "hi",
        "영어": "en",
        "스페인어": "es",
        "프랑스어": "fr",
//        "독일어": "de",
        "포르투갈어": "pt",
        "베트남어": "vi",
        "인도네시아어": "id",
//        "페르시아어": "fa",
//        "아랍어": "ar",
//        "미얀마어": "mm",
        "태국어": "th",
        "러시아어": "ru",
        "이탈리아어": "it",
        "알 수 없음": "unk"
    ]
}


