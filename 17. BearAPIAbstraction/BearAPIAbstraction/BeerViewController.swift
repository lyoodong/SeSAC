//
//  BeerViewController.swift
//  BearAPIAbstraction
//
//  Created by Dongwan Ryoo on 2023/09/20.
//

import UIKit
import SnapKit
import Kingfisher

class BeerViewController: UIViewController {
    
    lazy var beerImage:UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true //제스처를 위한 허용
        view.backgroundColor = .green
        
        return view
    }()
    
    let api = Network.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        constraints()
        request()
    }
    
    func request() {
        api.request(type: [Beer].self, api: .getRandomBeer) { response in
            switch response {
            case .success(let value):
                guard let url = URL(string: value[0].imageURL!) else { return }
                self.beerImage.kf.setImage(with: url)
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func addSubViews() {
        view.addSubview(beerImage)
    }
    
    func constraints() {
        beerImage.snp.makeConstraints {
            $0.center.equalTo(view)
            $0.size.equalTo(300)
        }
    }

}

