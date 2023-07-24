//
//  ViewController.swift
//  LEDBoard
//
//  Created by Dongwan Ryoo on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {

    //UI 프로퍼티 선언
    @IBOutlet var sendTextBar: UITextField!
    @IBOutlet var sendTextButton: UIButton!
    @IBOutlet var colorChnageButton: UIButton!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var searchBarStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    //보내기 버튼 액션
    @IBAction func sendTextButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        textLabel.text = sendTextBar.text
        sendTextBar.text = ""
    }
    
    //색상 변화 버튼 액션
    @IBAction func colorChangeButtonTapped(_ sender: UIButton) {
        let color:UIColor = UIColor.random()
        textLabel.textColor = color
        
    }
    
    //return 버튼 액션(키보드 내리기)
    @IBAction func returnTapped(_ sender: UITextField) {
        
    }
    
    //viewGesture, searchBarStackView 활성화/비활성화 토글
    @IBAction func viewGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        searchBarStackView.isHidden.toggle()
        
    }
    
    //set메서드 모음
    func setView() {
        sendTextBarSet(sendTextBar)
        sendTextButtonSet(sendTextButton)
        languegeChangeButtonSet(colorChnageButton)
        textLabelSet(textLabel)
        self.view.backgroundColor = .black
    }
    
    //sendTextBar 설정 메서드
    func sendTextBarSet(_ textField:UITextField) {
        textField.placeholder = "검색어를 입력해주세요"
        textField.layer.borderColor = UIColor.systemOrange.cgColor
        textField.layer.borderWidth = 2
        textField.keyboardType = .default
    }
    
    //sendTextButton 설정 메서드
    func sendTextButtonSet(_ button:UIButton) {
        button.titleLabel?.textColor = .black
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor.white.cgColor
    }
    
    //colorChnageButton 설정 메서드
    func languegeChangeButtonSet(_ button:UIButton) {
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor.white.cgColor
    }
    
    //textLabel 설정 메서드
    func textLabelSet(_ label:UILabel) {
        label.font = UIFont.systemFont(ofSize: 50)
        label.numberOfLines = 0
        label.textAlignment = .center
        
    }

}

//color 값 랜덤으로 생성하는 메서드
extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
