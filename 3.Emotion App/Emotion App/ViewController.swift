//
//  ViewController.swift
//  Emotion App
//
//  Created by Dongwan Ryoo on 2023/07/25.
//

import UIKit

//고정된 리터럴은 상수로 다 빼자

class ViewController: UIViewController {

    //clickCounts 딕셔너리 선언
    var clickCounts: [Emotion: Int] = [:]

    
    //UI 프로퍼티 선언
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    @IBOutlet var forthButton: UIButton!
    @IBOutlet var fifthButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    //디폴트 count값 0으로 세팅
    //Emotion을 순회하면서 각 case 추출 -> string으로 리턴 후 디폴트 값(0) 세팅
    //혹시 앱을 실행할 때, 감정 횟수를 전체 초기화하고 싶을 때 viewDidLoad에 실행
    func userDateSet() {
        for emotion in Emotion.allCases {
            let emotionToString = "\(emotion)"
            userDefualt.set(zeroDefualt, forKey: emotionToString)
        }
    }
    
    // 버튼 클릭 시 clickCountsCheck메서드 실행
    @IBAction func buttonTapped(_ sender: UIButton) {
        clickCountsCheck(sender)
    }
    
    // 클릭 횟수 저장, 출력하는 메서드
    func clickCountsCheck(_ sender: UIButton) {
        //optional 바인딩 -> Emotion의 멤버 추출
        guard let emotion = Emotion(rawValue: sender.tag) else { return }
        
        //딕셔너리에 감정의 case에 대한 count 횟수 저장(default 0)
        clickCounts[emotion, default: zeroDefualt] += 1
        
        //userdefault에 해당 횟수 저장
        userData(emotion, clickCounts[emotion]!)
    }
    
    //userdefault에 클릭 횟수 저장, 파라미터로 Emotion과 카운트 횟수 cnt를 받는다.
    func userData(_ emotion:Emotion, _ cnt:Int) {
        
        //키값으로 활용하기 위해 case 스트링으로 변환
        let emotionToString = "\(emotion)"
        
        //emotionToString 키값에 해당하는 value를 cnt로 할당
        userDefualt.set(cnt, forKey: emotionToString)
        
        //저장된 데이터 확인
        let cnt = userDefualt.integer(forKey: emotionToString)
        print("local기기에 데이터가 저장되었습니다.\(emotionToString)는 \(cnt)회 클릭")

    }
    
}

