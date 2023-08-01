//
//  Setting2TableViewController.swift
//  TableViewPractice
//
//  Created by Dongwan Ryoo on 2023/08/01.
//

import UIKit

enum SettingOptions:Int, CaseIterable {
    case total, personal, others
    
    //연산 프로퍼티가 get만 있다면 생략 가능하다.
    var mainOption:String {
        get {
            switch self {
            case .total: return "전체 설정"
            case .personal: return "개인 설정"
            case .others: return "기타 설정"
            }
        }
    }
    
    var subOptions:[String]{
        get {
            switch self {
            case .total: return ["공지사항", "실험실", "버전 정보"]
            case .personal: return ["개인보안", "알림", "채팅", "멀티프로필"]
            case .others: return ["고객센터/도움말"]
            }
        }
        
    }
    
}

class Setting2TableViewController: UITableViewController {
    
//    let first = ["공지사항, 실험실, 버전 정보"]
//    let second = ["개인보안, 알림, 채팅, 멀티프로필"]
//    let thrid = ["공지사항, 실험실, 버전 정보"]
//
//    let list = [
//        ["공지사항", "실험실", "버전 정보"],
//        ["개인보안", "알림", "채팅", "멀티프로필"],
//        ["고객센터/도움말"]
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        //        return list.count
        return SettingOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return list[section].count
        //SettingOptions의 전체 case중에 0번째 section의 서브 옵션을 호출하게 되면 스트링 배열이 오게 되고 그 배열의 요소 숫자가 그 섹션에
        //해당하는 텍스트 숫자
        return SettingOptions.allCases[section].subOptions.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"settingCell")!
        
//        cell.textLabel?.text = list[indexPath.section][indexPath.row]
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].subOptions[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].mainOption
    }
    
}
