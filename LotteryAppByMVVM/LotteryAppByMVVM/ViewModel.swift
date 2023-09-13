//
//  ViewModel.swift
//  LotteryAppByMVVM
//
//  Created by Dongwan Ryoo on 2023/09/13.
//

import Foundation

class ViewModel {
    
    var drawNo:[Int] = Array(1...1079).reversed()
    
    var list = observable(Result(drwtNo6: 0, drwtNo3: 0, drwtNo1: 0, drwtNo4: 0, drwNo: 0, firstAccumamnt: 0, returnValue: "", firstPrzwnerCo: 0, totSellamnt: 0, drwtNo5: 0, drwtNo2: 0, drwNoDate: "", bnusNo: 0, firstWinamnt: 0))

    
    func fetchData(row: Int)  {
        let num = drawNo[row]
        APIManager.shared.callRequest(num: num) { Result in
            self.list.value = Result
        }

    }
    
    func selectedLottoNum(row: Int) -> Int {
        return drawNo[row]
    }
    
    func numberOfRowsInComponent() -> Int {
        return drawNo.count
    }
    
}
