//
//  StaticsViewController.swift
//  Emotion App
//
//  Created by Dongwan Ryoo on 2023/07/26.
//

import UIKit

class StaticsViewController: UIViewController {

    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    @IBOutlet var forthLabel: UILabel!
    @IBOutlet var fifthLabel: UILabel!
    
    //viewWillAppear에 처리 -> 뷰가 나타나기 전에 데이터 셋팅
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countSet()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func countSet() {
        //enumerated()를 통해 Emotion의 케이스에 인덱스 부여
        for (index, emotion) in Emotion.allCases.enumerated() {
            //key값으로 활용하기 위해 case string으로 형변환
            let emotionToString = "\(emotion)"
            //감정에 해당하는 count 값 result에 할당 후, label배열의 인덱스와 Emotion의 인덱스를 매칭 후, text에 count값 할당.
            if let result = userDefualt.string(forKey: emotionToString) {
                let labelArray = [firstLabel, secondLabel, thirdLabel, forthLabel, fifthLabel]
                labelArray[index]?.text = result
            }
        }
    }
}
