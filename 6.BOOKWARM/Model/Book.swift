//
//  Book.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/08/09.
//

import UIKit

struct Book {
    let thumbnail:String //책 표지
    let title:String //제목
    let authors:[String] //저자 배열
    let publisher:String //출판사
    let contents:String // 도서 소개
    let datetime:String //출간일
    let sale_price:String //판매가
    let url:String //상세 url
    var like:Bool = false
    var color:UIColor = UIColor.random()
    
    var bookRelatedInfo:String {
        return "출판사:\(self.publisher)\n저자:\(self.authors.joined(separator: ", "))"
    }

}
