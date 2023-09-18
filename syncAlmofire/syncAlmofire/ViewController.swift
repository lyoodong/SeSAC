//
//  ViewController.swift
//  syncAlmofire
//
//  Created by Dongwan Ryoo on 2023/09/17.
//

import UIKit

class ViewController: UIViewController {
    
    let searchController = UISearchController()
    let API = APIManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchControllerSet()
    }
    
    func searchControllerSet() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "검색어를 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.tintColor = .systemPink
        searchController.searchBar.barStyle = .black
        navigationItem.searchController = searchController
    }
    
}

extension ViewController: UISearchBarDelegate {
    //실시간 검색
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        API.syncRequest(searchText: searchText) { Result, Error in
            if let Result = Result {
                print("도착", searchText)
            } else if let Error = Error {
                print(Error)
            }
        }
    }
    
    //취소 버튼 클릭
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    //검색 버튼 클릭
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

