//
//  Book.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/08/09.
//

import UIKit
import RealmSwift

class Book {
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
    
    init(thumbnail: String, title: String, authors: [String], publisher: String, contents: String, datetime: String, sale_price: String, url: String) {
        self.thumbnail = thumbnail
        self.title = title
        self.authors = authors
        self.publisher = publisher
        self.contents = contents
        self.datetime = datetime
        self.sale_price = sale_price
        self.url = url
    }
}

class RealmModel:Object {
    @Persisted(primaryKey: true) var bookId:ObjectId
    @Persisted var thumbnail: String
    @Persisted var title: String
    @Persisted var authors: List<String>
    @Persisted var publisher: String
    @Persisted var contents: String
    @Persisted var datetime: String
    @Persisted var sale_price: String
    @Persisted var url: String
    @Persisted var like: Bool
    var color:UIColor?
    var bookRelatedInfo:String {
        return "출판사:\(self.publisher)\n저자:\(self.authors.joined(separator: ", "))"
    }
    
    convenience init(thumbnail: String, title: String, authors: [String], publisher: String, contents: String, datetime: String, sale_price: String, url: String, like:Bool, color:UIColor ) {
        self.init()
        self.thumbnail = thumbnail
        self.title = title
        self.authors.append(objectsIn: authors)
        self.publisher = publisher
        self.contents = contents
        self.datetime = datetime
        self.sale_price = sale_price
        self.url = url
        self.like = like
        self.color = color
    }
}
