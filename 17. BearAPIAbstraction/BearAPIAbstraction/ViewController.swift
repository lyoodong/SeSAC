//
//  ViewController.swift
//  BearAPIAbstraction
//
//  Created by Dongwan Ryoo on 2023/09/19.
//

import UIKit

class ViewController: UIViewController {
    
    let api = APIManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        api.getBeers { result in
            print("1. api.getBeers", result)
        }
        
        api.getRandomBeers { result in
            print("2. api.getRandomBeers", result)
        }
        
        api.getSingleBeers(id: "22") { result in
            print("3. api.getSingleBeers", result)
        }
    }
    
}

