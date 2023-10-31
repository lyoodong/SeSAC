//
//  RxTextFieldViewController.swift
//  RxTableView
//
//  Created by Dongwan Ryoo on 2023/11/01.
//

import UIKit
import RxSwift
import RxCocoa

class RxTextFieldViewController: UIViewController {

    @IBOutlet var TextField1: UITextField!
    @IBOutlet var TextField2: UITextField!
    @IBOutlet var TextField3: UITextField!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
//        setCombineLatestTextField()
        setZipTextField()
    }
    
    func setCombineLatestTextField() {
        //orEmpty -> 옵셔널 값을 Observable 스트림으로 변환
        
        //combineLatest 두 값이 모두 변화해야 옵저버블 방출
        Observable.combineLatest(
            TextField1.rx.text.orEmpty,
            TextField2.rx.text.orEmpty) { num1, num2 -> Int in
                return (Int(num1) ?? 0)  + (Int(num2) ?? 0)
            }
            .map { $0.description }
            .bind(to: TextField3.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setZipTextField() {
        
        //zip 두 값이 모두 변화해야 옵저버블 방출
        Observable.zip(
            TextField1.rx.text.orEmpty,
            TextField2.rx.text.orEmpty) { num1, num2 -> Int in
                return (Int(num1) ?? 0)  + (Int(num2) ?? 0)
            }
            .map { $0.description }
            .bind(to: TextField3.rx.text)
            .disposed(by: disposeBag)
    }
}
