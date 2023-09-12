//
//  ViewModel.swift
//  LoginExample
//
//  Created by Dongwan Ryoo on 2023/09/12.
//

import Foundation

class ViewModel {
    
    var id = Observable("")
    var pw = Observable("")
    var nickname = Observable("")
    var phoneNumber = Observable("")
    var isValid = Observable(false)
    
    func checkValidation() {
        if id.value.count > 10 && String(phoneNumber.value).count == 11 {
            isValid.value = true
        } else {
            isValid.value = false
        }
    }
    
    func autoID(completion: @escaping (() -> Void)) {
        UserDefaults.standard.set(id.value, forKey: "id")
        completion()
    }
}
