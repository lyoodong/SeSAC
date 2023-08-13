//
//  ViewController.swift
//  day3
//
//  Created by Dongwan Ryoo on 2023/07/20.
//

import UIKit

class ViewController: UIViewController {

    // UI 프로퍼티
    @IBOutlet var datePick: UIDatePicker!
    @IBOutlet var firstDayLabel: UILabel!
    @IBOutlet var day100Label: UILabel!
    @IBOutlet var day200Label: UILabel!
    @IBOutlet var day300Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickSet()
        // 레이블관련 공통 요소 설정
        [firstDayLabel, day100Label, day200Label, day300Label].forEach { label in
            labelSet(label)
        }
        //추가 viewdidload에 추가하면 화면 빌드시 오늘 날(디폴트로 선택된 날)의 기준으로 sender.date의 값을 바로 업데이트할 수 있다.
        datepickerValueChanged(datePick)
    }
    
    //datepicker 액션
    @IBAction func datepickerValueChanged(_ sender: UIDatePicker) {
        labelTextSet()
    }
    
    //날짜 더하는 메서드
    func addDate(_ addDay:Int) -> String {
        let Anniversary = Calendar.current.date(byAdding: Calendar.Component.day, value: addDay, to: datePick.date)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy년 M월 d일"
        let value = dateformatter.string(from: Anniversary!)

       return value
    }
    
    //데이터 피커관련 set
    func datePickSet() {
        if #available(iOS 14.0, *) {
            datePick.preferredDatePickerStyle = .inline
        } else {
            datePick.preferredDatePickerStyle = .wheels
        }
        datePick.tintColor = .systemGreen
        datePick.timeZone = .current
    }
    //레이블관련 set
    func labelSet(_ label:UILabel) {
        label.text = "날짜를 선택해주세요"
        label.layer.cornerRadius = label.frame.width / 2
        //공부
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.clipsToBounds = true
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
    }
    //레이블 텍스트 할당하는 메서드
    func labelTextSet() {
        firstDayLabel.text = "만난날: \(addDate(0))"
        day100Label.text = "100일: \(addDate(100))"
        day200Label.text = "200일: \(addDate(200))"
        day300Label.text = "300일: \(addDate(300))"
    }

}

