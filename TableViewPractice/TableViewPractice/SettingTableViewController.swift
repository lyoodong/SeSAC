//
//  SettingTableViewController.swift
//  TableViewPractice
//
//  Created by Dongwan Ryoo on 2023/07/27.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    //section과 cell에 들어갈 데이터를 저장한 배열
    let sectionTitle = ["전체 설정","개인 설정","기타"]
    let wholeSet = ["공지사항", "실험실"]
    let personalSet = ["개인/보안", "알림", "채팅","멀티프로필"]
    let etcSet = ["고객센터/도움말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSet()
    }
    
    //테이블뷰 관련 세팅
    func tableViewSet() {
        tableView.backgroundColor = .black
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
    }
    
    // MARK: - Table view data source
    
    //각 section의 cell 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return wholeSet.count
        case 1:
            return personalSet.count
        case 2:
            return etcSet.count
        default:
            return 0
        }
        
    }
    
    //section의 수
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionTitle.count
    }
    
    //cell 등록 및 레이아웃 설정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = wholeSet[indexPath.row]
        case 1:
            cell.textLabel?.text = personalSet[indexPath.row]
        case 2:
            cell.textLabel?.text = etcSet[indexPath.row]
        default:
            cell.textLabel?.text = ""
        }
        
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return sectionTitle[section]
    
    }
}
