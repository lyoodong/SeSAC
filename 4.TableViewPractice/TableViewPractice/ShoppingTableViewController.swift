//
//  ShoppingTableViewController.swift
//  TableViewPractice
//
//  Created by Dongwan Ryoo on 2023/07/27.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    var list:[String] = [] //cell에 들어갈 shopping list 배열
    let numOfSection =  1 //section의 갯수
    let userData = UserDefaults.standard
    
    //UI 프로퍼티
    @IBOutlet var addTextField: UITextField!
    @IBOutlet var addTextButton: UIButton!
    @IBOutlet var delTextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
    }
    
    func viewSet() {
        tableViewSet()
        textFieldSet(addTextField)
        buttonSet(addTextButton)
        buttonSet(delTextButton)
        loadData()
    }
    
    //tableView 셋팅
    func tableViewSet() {
        tableView.backgroundColor = .white
    }
    //textField 셋팅
    func textFieldSet(_ textField:UITextField) {
        textField.placeholder = "무엇을 구매하실 간가요?"
        
    }
    //button 셋팅
    func buttonSet(_ button:UIButton) {
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .lightGray
    }
    
    //추가 button 액션
    @IBAction func addTextButtonTapped(_ sender: UIButton) {
        guard let addText = addTextField.text else { return }
        list.append(addText)
        tableView.reloadData()
        addTextField.text = ""
        saveDate()
    }
    
    //삭제 button 액션
    @IBAction func delTextButtonTapped(_ sender: Any) {
        list.removeLast()
        tableView.reloadData()
        saveDate()
    }
    
    //추가된 쇼핑 리스트 UserDefaults에 저장
    func saveDate() {
        userData.set(list, forKey: "shoppingList") //shoppingList를 키값으로 list배열 저장
    }
    
    //추가된 쇼핑 리스트 호출
    func loadData() {
        // 데이터 호출 후 savedList에 저장. Any타입을 String 타입으로 형변환
        guard let savedList = userData.array(forKey: "shoppingList") as? [String] else { return }
        //저장된 Data 다시 list에 할당
        list = savedList
        //테이블 뷰 cell데이터 reloadData()
        tableView.reloadData()
        }

    
    // MARK: - Table view data source
    
    //section 수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return numOfSection
    }
    
    //cell의 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    //cell 등록 및 레이아웃 설정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell") else { return UITableViewCell()}
        
        cell.backgroundColor = .systemGray6
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
        
    }
    
}
