//
//  RxPickerViewController.swift
//  RxTableView
//
//  Created by Dongwan Ryoo on 2023/11/01.
//

import UIKit
import RxSwift
import RxCocoa

final class RxPickerViewController: UIViewController {
    
    @IBOutlet var pickerView1: UIPickerView!
    @IBOutlet var pickerView2: UIPickerView!
    @IBOutlet var pickerView3: UIPickerView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPickerView1()
        setPickerView2()
        setPickerView3()
    }
    
    private func setPickerView1() {
        
        //pickerView에 itemTitles 리턴
        Observable.just(["철수", "영희", "미애"])
            .bind(to: pickerView1.rx.itemTitles) { _, item in
                return item
            }.disposed(by: disposeBag)
        
        pickerView1.rx.modelSelected(String.self)
            .bind { models in
                print("선태된 친구는 \(models.first!)")
            }.disposed(by: disposeBag)
    }
    
    private func setPickerView2() {
        
        //pickerView에 itemAttributedTitles 리턴
        Observable.just([1, 2, 3])
            .bind(to: pickerView2.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)",
                                          attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.cyan,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                                          ])
            }
            .disposed(by: disposeBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .bind(onNext: { models in
                print("\(models.first!)의 색상은 cyan")
            })
            .disposed(by: disposeBag)
        
        
    }
    
    private func setPickerView3() {
        
        //pickerView에 커스텀 뷰 리턴
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickerView3.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)
        
        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { models in
                print("models selected 3: \(models)")
            })
            .disposed(by: disposeBag)
        
    }
}

