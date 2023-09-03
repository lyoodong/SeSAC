//
//  TextChnageViewController.swift
//  10. MediaProject
//
//  Created by Dongwan Ryoo on 2023/08/29.
//

import UIKit
import SnapKit

protocol passTextData {
    func passData(text:String)
}

class TextChnageViewController: UIViewController {
    
    
    lazy var textFields:UITextField = {
        let view = UITextField()
        view.placeholder = "  변경 사항을 입력해주세요."
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    var delegate:passTextData?
    var passText:((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(textFields)
        textFields.snp.makeConstraints { make in
            make.center.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        guard let text = textFields.text else {return}
        
        let noti = NotificationCenter.default
        noti.post(name: NSNotification.Name("text"), object: nil, userInfo: ["text" : text])
        
        delegate?.passData(text: text)
        passText?(text)
    }
    
    
}
