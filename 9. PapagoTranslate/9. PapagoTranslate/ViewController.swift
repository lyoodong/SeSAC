//
//  ViewController.swift
//  9. PapagoTranslate
//
//  Created by Dongwan Ryoo on 2023/08/10.
//

import Alamofire
import SwiftyJSON
import UIKit

class ViewController: UIViewController {
    //MARK: - Property
    
    //MARK: - UI property
    @IBOutlet var inputTextView: UITextView!
    @IBOutlet var outputTextView: UITextView!
    @IBOutlet var langSelectTextField: UITextField!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    let pickerView = UIPickerView()
    
    
    //MARK: - Define UI Method
    override func viewDidLoad() {
        super.viewDidLoad()
        translateButtonSet(translateButton)
        langSelectTextFieldSet(langSelectTextField)
        [inputTextView, outputTextView].forEach { view in
            textViewSet(view)
        }
        indicatorView.isHidden = true
    }
    
    //번역버튼
    func translateButtonSet(_ button:UIButton) {
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("번역", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(translateButtonClicked), for: .touchUpInside)
    }
    
    //번역버튼 클릭 시 이벤트
    @objc
    func translateButtonClicked() {
        callRequestDetectLangs()
    }
    
    //언어 선택 텍스트필드
    func langSelectTextFieldSet(_ textField:UITextField) {
        textField.placeholder = "언어를 선택해주세요."
        textField.inputView = pickerView
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    //인풋, 아웃풋 텍스트뷰
    func textViewSet(_ textView:UITextView) {
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.systemGray.cgColor
        textView.layer.borderWidth = 2
        
    }
    
    //MARK: - Define Network Method
    
    //언어 감지 메서드
    func callRequestDetectLangs(){
        
        let url = "https://openapi.naver.com/v1/papago/detectLangs"
        //post는 파라미터 형태로 보내줘야한다
        let prameter:Parameters = [
            "query" : inputTextView.text ?? ""
        ]
        
        
        AF.request(url, method: .post, parameters: prameter, headers: APIKey.NAVERKey).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                //네트워크 요칭 시 indicatorView 보이게 하기
                self.indicatorView.isHidden = false
                self.indicatorView.startAnimating()
                
                let json = JSON(value)
                //감지된 언어 langCode에 할당
                let langCode = json["langCode"].stringValue
                print(langCode)
                
                //텍스트 필드에서 선택한 언어
                let seletedLang = self.langSelectTextField.text ?? "알 수 없음"
                //선택한 언어를 키로 target으로 보낼 벨류로 변환
                guard let target = LangType.langDic[seletedLang] else {return}
                print(target)
                self.callRequestTrnaslateLangs(lnagCode: langCode, target: target)

                /*처음에는 translateButtonClicked() 메서드 내부에서 callRequestDetectLangs()를 통해 언어를 감지하고
                 감지한 langCode를 return langCode ?? "unk"로 반환하도록 코드를 작성했다.
                 이후, 리턴값을 callRequestDetectLangs() 메서드의 lnagCode 인자값으로 받아 처리했으나,
                 프린트를 찍어보니, translateButtonClicked 실행 시점에서는 반환값이 항상 unk(기본값) 으로 찍혔다.
                 그 후, translateButtonClicked 실행 한참 후에 callRequestDetectLangs()에서 langCode값이 정상적으로 출력됐다.
                 찾아보니깐, network관련 코드는 비동기적으로 실행되기 때문에 순차적인 코드 진행이 아닐 수 있었다.
                 차후에, 비동기처리에 대한 내용을 학습 후 원인을 파악해보기.
                 */
                
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    //언어 번역 메서드
    func callRequestTrnaslateLangs(lnagCode:String, target:String) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let prameter:Parameters = [
            "source" : lnagCode,
            "target" : target,
            "text" : inputTextView.text ?? ""
        ]
        
        AF.request(url, method: .post,parameters: prameter  ,headers: APIKey.NAVERKey).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // 번역한 결과
                let output = json["message"]["result"]["translatedText"].stringValue
                // 결과 텍스트뷰에 할당
                self.outputTextView.text = output
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

//MARK: - extension
extension ViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LangType.langDic.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //LangType.langDic.values 스위프트의 딕셔너리에서 키, 벨류의 합을 나타내는 특수한 컬렉션, 일반 배열로 형변환 필요.
        let keyArray = Array(LangType.langDic.keys)
        langSelectTextField.text = keyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let keyArray = Array(LangType.langDic.keys)
        let langText = keyArray[row]
        return langText
    }
    
    
}

