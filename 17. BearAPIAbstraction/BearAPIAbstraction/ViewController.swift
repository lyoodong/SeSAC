//
//  ViewController.swift
//  BearAPIAbstraction
//
//  Created by Dongwan Ryoo on 2023/09/19.
//

import UIKit

class ViewController: UIViewController {
    
    let api = BeerAPIManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        api.getBeers { result in
            print("1. api.getBeer", result)
        }
        
        api.getRandomBeer { result in
            print("2. api.getRandomBeer", result)
        }
        
        api.getSingleBeer(id: "22") { result in
            print("3. api.getSingleBeer", result)
        }
    }
    
}

