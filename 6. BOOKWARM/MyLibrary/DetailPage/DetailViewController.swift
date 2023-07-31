//
//  DetailViewController.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let IDF = "DetailViewController"
    
    lazy var movieTitle:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        title = movieTitle
    }
    
}
