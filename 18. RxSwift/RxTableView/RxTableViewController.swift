//
//  ViewController.swift
//  RxTableView
//
//  Created by Dongwan Ryoo on 2023/10/26.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
    
    //기본 UI 선언
    @IBOutlet var tableView: UITableView!
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var label2: UILabel!
    
    //Cell의 textLabel에 들어갈 Data
    
    let cities = ["Lisbon", "Copenhagen", "London", "Madrid", "Vienna"]
    let countries = ["포루투갈", "덴마크", "영국", "스페인", "오스트리아"]
    lazy var array = Observable.of(cities, countries)
    
    //disposeBag
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
        driveButton()
    }
    
    func driveButton() {
        
        let tapButton = button.rx.tap
            .map { "안녕하세요 \(Int.random(in: 1...100))" }
            .asDriver(onErrorJustReturn: "")
    

        tapButton.drive(label.rx.text)
            .disposed(by: disposeBag)
        
        tapButton.drive(label2.rx.text)
            .disposed(by: disposeBag)
    }
    
    
    func bindTableView() {
        
        array
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
                cell.textLabel?.text = element

                return cell
            }.disposed(by: disposeBag)
        
        array
            .bind(to: tableView.rx.items) { tableView, row, element in
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
                print(element)
                
                return cell
                
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .map { data in
                "\(data) 클릭"
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}

