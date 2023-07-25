//
//  ViewController.swift
//  Emotion App
//
//  Created by Dongwan Ryoo on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    //button의 tag와 rawValue가 대응되도록 enum 타입 구성
    enum Emotion:Int {
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
        
    }
    // 버튼 클릭 시 clickCountsCheck메서드 실행
    @IBAction func buttonTapped(_ sender: UIButton) {
        clickCountsCheck(sender)
    }
    
    // 클릭 횟수 저장, 출력하는 메서드
    func clickCountsCheck(_ sender: UIButton) {
        //optional 바인딩 -> Emotion의 멤버 추출
        guard let emotion = Emotion(rawValue: sender.tag) else { return }
    
        //optional 언래핑
        clickCounts[emotion, default: 0] += 1
        print("\(emotion) 버튼은 \(clickCounts[emotion]!)번 클릭되었습니다.")
    }
    
}

