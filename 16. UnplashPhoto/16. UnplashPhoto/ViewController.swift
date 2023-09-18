//
//  ViewController.swift
//  16. UnplashPhoto
//
//  Created by Dongwan Ryoo on 2023/09/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    
    lazy var imageView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        return view
    }()
    
    lazy var selectImageTypeTextFields:UITextField = {
        let view = UITextField()
        view.placeholder = "받을 이미지의 타입을 입력해주세요."
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(selectImageTypeTextFields)
        constraints()
        bind()
        addtarget()
    }
    
    func bind() {
        viewModel.imageLinkType.bind { linkType in
            self.viewModel.fetch(linkType)
            self.loadImage()
        }
    }
    
    func loadImage() {
        let link = self.viewModel.link
        print(link, "====")
        
        DispatchQueue.global().async {
            guard let url = URL(string: link), let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }
    }
    
    func addtarget() {
        selectImageTypeTextFields.addTarget(self, action: #selector(changeImage), for: .editingChanged)
    }
    
    @objc
    func changeImage() {
        viewModel.imageLinkType.value = selectImageTypeTextFields.text!
    }
    
    func constraints() {
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().inset(300)
        }
        
        selectImageTypeTextFields.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
    
}

