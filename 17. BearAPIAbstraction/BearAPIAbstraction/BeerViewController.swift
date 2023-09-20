//
//  BeerViewController.swift
//  BearAPIAbstraction
//
//  Created by Dongwan Ryoo on 2023/09/20.
//

import UIKit
import Kingfisher
import SnapKit

class BeerViewController: UIViewController {
    
    private lazy var beerImage: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true //제스처를 위한 허용
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.minimumZoomScale = 1 //최소 확대
        view.maximumZoomScale = 2 //최대 확대
        view.bouncesZoom = true
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        return view
    }()

    let viewModel = BeerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        constraints()
        configureGesture()
        
        viewModel.request { URL in
            self.beerImage.kf.setImage(with: URL)
        }
    }
    
    func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(beerImage)
    }
    
    func constraints() {
        scrollView.snp.makeConstraints {
            $0.center.equalTo(view)
            $0.size.equalTo(400)
        }
        
        beerImage.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.centerX.equalTo(view)
        }
    }
    
    func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        
        tap.numberOfTapsRequired = 2 //제스쳐를 실행하려면 몇회의 탭이 필요한지?
        beerImage.addGestureRecognizer(tap)
    }
    
    @objc
    func doubleTapGesture() {
        let scale = scrollView.zoomScale
        
        if scale == 1 {
            scrollView.setZoomScale(2, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }

}

extension BeerViewController: UIScrollViewDelegate {
    //확대할 view를 리턴
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return beerImage
    }
}
