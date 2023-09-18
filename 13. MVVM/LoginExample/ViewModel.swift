//
//  ViewModel.swift
//  LoginExample
//
//  Created by Dongwan Ryoo on 2023/09/12.
//

import Foundation

enum loginError: Error {
    case id
    case password
    case nickname
    case referralCode
}

class ViewModel {
    
    var id = Observable("")
    var pw = Observable("")
    var nickname = Observable("")
    var referralCode = Observable("")
    var isValid = Observable(false)
    
    func checkValidation() throws {
        
        if !id.value.contains("@") {
            throw loginError.id
        } else if !(pw.value.count > 6 && pw.value.count < 11) {
            throw loginError.password
        } else if nickname.value.isEmpty {
            throw loginError.nickname
        } else if referralCode.value.count != 6 {
            throw loginError.referralCode
        } else {
            isValid.value = true
        }
    }

    func autoID(completion: @escaping (() -> Void)) {
        UserDefaults.standard.set(id.value, forKey: "id")
        completion()
    }

}
