//
//  ViewController.swift
//  LotteryAppByMVVM
//
//  Created by Dongwan Ryoo on 2023/09/13.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    
    lazy var searchDrawNo: UITextField = {
        let view = UITextField()
        view.placeholder = "회차를 선택해주세요."
        view.inputView = pickerView
        
        return view
    }()
    
    lazy var resultLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        
        return view
    }()
    
    lazy var pickerView: UIPickerView = {
        let view = UIPickerView()
        view.inputViewController?.isEditing = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addsubview()
        constraint()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        viewModel.list.bind { Result in
            var numbers:[Int] = []
            var bonus:Int = 0
            
            numbers = [Result.drwtNo1, Result.drwtNo2, Result.drwtNo3, Result.drwtNo4, Result.drwtNo5, Result.drwtNo6]
            bonus = Result.bnusNo
            
            self.resultLabel.text = "당첨번호: \(numbers)\n보너스 번호:\(bonus)"
        }
    }
    
    func addsubview() {
        [searchDrawNo, resultLabel].forEach {
            view.addSubview($0)
        }
    }
    
    func constraint() {
        searchDrawNo.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(16)
            make.top.equalTo(100)
            make.height.equalTo(50)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(16)
            make.top.equalTo(searchDrawNo.snp.bottom).offset(16)
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfRowsInComponent()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        searchDrawNo.text = "\(viewModel.selectedLottoNum(row: row))"
        viewModel.fetchData(row: row)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return "\(viewModel.selectedLottoNum(row: row)) 회차"
    }
}


