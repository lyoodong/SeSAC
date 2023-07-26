//
//  ViewController.swift
//  Emotion App
//
//  Created by Dongwan Ryoo on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    //button의 tag와 rawValue가 대응되도록 enum 타입 구성
    enum Emotion:Int, CaseIterable {
        case happy
        case good
        case just
        case soso
        case angry
    }

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
        userDateSet()
        
    }
    //디폴트 count값 0으로 세팅
    //Emotion을 순회하면서 각 case 추출 -> string으로 리턴 후 디폴트 값(0) 세팅
    func userDateSet() {
        for emotion in Emotion.allCases {
            let emotionToString = String(describing: emotion)
            UserDefaults.standard.set(0, forKey: emotionToString)
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
        clickCounts[emotion, default: 0] += 1
        
        //userdefault에 해당 횟수 저장
        userData(emotion, clickCounts[emotion]!)
    }
    
    //userdefault에 클릭 횟수 저장, 파라미터로 Emotion과 카운트 횟수 cnt를 받는다.
    func userData(_ emotion:Emotion, _ cnt:Int) {
        
        //키값으로 활용하기 위해 case 스트링으로 반환
        let emotionToString = String(describing: emotion )
        
        //emotionToString 키값에 해당하는 value를 cnt로 할당
        UserDefaults.standard.set(cnt, forKey: emotionToString)
        
        //저장된 데이터 확인
        let cnt = UserDefaults.standard.integer(forKey: emotionToString)
        print("local기기에 데이터가 저장되었습니다.\(emotionToString)는 \(cnt)회 클릭")

    }
    
}

