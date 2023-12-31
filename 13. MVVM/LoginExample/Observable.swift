//
//  Observable.swift
//  LoginExample
//
//  Created by Dongwan Ryoo on 2023/09/12.
//

import Foundation

class Observable<T> {
    private var listener: ((T) -> Void)?
    
    var value:T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping ((T) -> Void)) {
        closure(value)
    }
}
