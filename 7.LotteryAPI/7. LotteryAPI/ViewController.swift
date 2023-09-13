//
//  ViewController.swift
//  7. LotteryAPI
//
//  Created by Dongwan Ryoo on 2023/08/08.
//

import Alamofire
import SwiftyJSON
import UIKit
//1. 데이터를 호출할 url
//2. 리퀘스트 보낼 코드 작성
//3. UI선언(회차를 선택할 picker와 textFields, 선택한 회차의 로또 당첨 번호를 표기할 label)
//4. 제이슨 구조 확인 후 원하는 정보 선택해서 print(), 이때 값을 .intValue, .stringValue 등을 활용해 변환해줘야 한다.
//5. 원하는 값을 가져오면 뷰에 값을 할당해 준다.
/*6. 이번과제에서 유의할 점
 - 텍스트필드의 인풋 뷰에 피커뷰 할당
 - 피커뷰 데이터소스, 델리게이트 설정(row개수, row에 표시될 텍스트)
 - 특정 범위의 숫자 배열 생성 + 역전시키기
 - 배열을 다시 스트링으로 변경하기 ary.join()
 - 리퀘스트 보낼 시 다시 결과 배열 초기화하기, 아니면 번호가 계속 쌓임
 */

class ViewController: UIViewController {
    
    var num = 1079
    let pickerView = UIPickerView()
    var drwoNum:[String] = []
    var drawNo:[Int] = Array(1...1079).reversed()
    @IBOutlet var resultText: UILabel!
    @IBOutlet var searchDrawNo: UITextField!
    @IBOutlet var drawNoText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
        uiSet()
    }
    
    func uiSet() {
        searchDrawNo.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func callRequest() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(num)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                print(json)
                
                //일반 당첨번호 호출 후 배열에 추가
                for item in 0...5 {
                    let drwNo = json["drwtNo\(item + 1)"].intValue
                    self.drwoNum.append("\(drwNo), ")
                }
                //보너스 당첨번호 후 배열에 추가
                let bonusNo = json["bnusNo"].intValue
                self.drwoNum.append("\(bonusNo)")
                
                //회차 호출
                let drawNo = json["drwNo"].intValue
                
                //당첨번호 배열을 스트링으로 변환 후, resultText 할당
                self.resultText.text = self.drwoNum.joined()
                //회차 drawNoText에 할당
                self.drawNoText.text = "\(drawNo)회 로또 당첨 번호"
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func dataReset() {
        self.drawNoText.text = ""
        self.drwoNum.removeAll()
    }
    
}

extension ViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return drawNo.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        searchDrawNo.text = "\(drawNo[row])"
        num = drawNo[row]
        dataReset()
        callRequest()
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            
        return "\(drawNo[row])"
    }
    
}

