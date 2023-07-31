//
//  AutoLayoutViewController.swift
//  day3
//
//  Created by Dongwan Ryoo on 2023/07/21.
//

import UIKit

class AutolayoutViewController: UIViewController {

    
    @IBOutlet var searchBarTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var buttonCollections: [UIButton]!
    @IBOutlet var resultBoxImage: UIImageView!
    
    let wordsDictonary:[String:String] = ["별다줄": "별걸 다 줄인다.", "알잘딱깔센":"알아서 잘 딱 깔끔하고 센스있게", "JMT": "존맛탱"  ]
    
    //개선점 -> 버튼의 텍스트 버튼의 태그를 활용해서 할당
    let wordList:[String] = ["별다줄", "알잘딱깔센", "JMT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
    }

    //return키 클릭 시 이벤트
    @IBAction func enterTapped(_ sender: UITextField) {
      
        //한단어 or nil값일 경우. -> 경고창 실행
        // 아닐 경우 정상적으로 처리
        if searchBarTextField.text?.isEmpty == true || searchBarTextField.text?.count == 1 {
            present(alert(), animated: true)
        } else {
            let searchItem = searchBarTextField.text
            resultLabel.text = wordsDictonary[searchItem!] ?? "사전에 없는 검색어 입니다."
        }

    }

    
    //버튼 클릭 시 이벤트
    @IBAction func firstButtonTapped(_ sender: UIButton) {
        searchBarTextField.text = sender.currentTitle!
        enterTapped(searchBarTextField)
    }
    
    //UI관련 세팅 메서드 모음
    func viewSet() {
        searchBarTextFieldSet()
        buttonSet()
        resultLabelSet()
        resultBoxImageSet()

    }
    
    //searchBarTextField관련 set
    func searchBarTextFieldSet() {
        searchBarTextField.placeholder = "   검색어를 입력해주세요."
        searchBarTextField.backgroundColor = .white
        searchBarTextField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        searchBarTextField.borderStyle = .line
        searchBarTextField.layer.borderWidth = 2
    }
    
    //button관련 set
    func buttonSet() {
        for item in buttonCollections {
            buttonSetting(button: item)
        }
    }
    
    //button관련 공통 요소 set
    func buttonSetting(button:UIButton) {
        //개선점 -> 버튼의 텍스트 버튼의 태그를 활용해서 할당
        let title = wordList[button.tag]
        button.setTitle(title, for: .normal)
        
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.textColor = .black
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
    }
    
    func resultLabelSet() {
        resultLabel.text = "검색어를 입력해주세요."
        resultLabel.backgroundColor = .white
    }
    
    //resultBoxImage관련 set
    func resultBoxImageSet() {
        resultBoxImage.image = UIImage(named: "background")
        resultLabel.contentMode = .scaleAspectFill
    }
    
    //alert 정의 후 리턴
    func alert() -> UIAlertController {
        let alert = UIAlertController(title: "최소 2자 이상 입력해주세요.", message: nil, preferredStyle: .alert)
        let warning = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(warning)
        
        return alert
        
    }
 
}
