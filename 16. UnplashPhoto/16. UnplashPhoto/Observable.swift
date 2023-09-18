//
//  Observable.swift
//  16. UnplashPhoto
//
//  Created by Dongwan Ryoo on 2023/09/18.
//

import Foundation

class Observable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ handler: @escaping (T) -> Void) {
        handler(value)
        listener = handler
    }
}
