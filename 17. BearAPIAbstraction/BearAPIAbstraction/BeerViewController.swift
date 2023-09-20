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
    
    private lazy var beerImage: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true //제스처를 위한 허용
        view.backgroundColor = .green
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.minimumZoomScale = 1 //최소 확대
        view.maximumZoomScale = 6 //최대 확대
        view.delegate = self
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
        view.addSubview(scrollView)
        scrollView.addSubview(beerImage)
    }
    
    func constraints() {
        scrollView.snp.makeConstraints {
            $0.center.equalTo(view)
            $0.size.equalTo(300)
        }
        
        beerImage.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
        }
    }

}

extension BeerViewController: UIScrollViewDelegate {
    //확대할 view를 리턴
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return beerImage
    }
}
