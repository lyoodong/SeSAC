//
//  SearchViewController.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        backButtonSet()
    }
    
    func backButtonSet() {
        title = "검색 화면"
        let image = UIImage(systemName: "xmark")
        let backbutton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backbutton
        backbutton.tintColor = .black
        
    }
    
    @objc
    func backButtonTapped() {
        
        dismiss(animated: true)
        
    }
    

}
