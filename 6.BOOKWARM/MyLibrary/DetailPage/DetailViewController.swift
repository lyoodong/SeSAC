//
//  DetailViewController.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//

import Kingfisher
import UIKit
import SnapKit
import RealmSwift

class DetailViewController: UIViewController {
    //MARK: - property
    static let IDF = "DetailViewController"
    lazy var movieTitle:String = ""
    lazy var placeholderText:String = "텍스트 입력"
    var bookList:Book?
    var id: ObjectId?
    var task: RealmModel?
    //MARK: - UI porperety
    @IBOutlet var bookImage: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookRelatedInfo: UILabel!
    @IBOutlet var bookDateLabel: UILabel!
    @IBOutlet var bookPriceLabel: UILabel!
    @IBOutlet var bookOverViewLabel: UILabel!
    @IBOutlet var memoTextView: UITextView!
    
    lazy var toolBar:UIToolbar = {
        let view = UIToolbar()
        view.isTranslucent = false
        view.barTintColor = .black
        return view
    }()
    
    func toolBarSet() {
        let delete = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deleteButtonClicked))
        let mod = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(modButtonClicked))
        let Flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.items = [delete, Flexible, mod]

    }
    
    @objc func deleteButtonClicked() {
        LDRealm.shared.delete(object: task!)
        removeImageFromDocumet(fileName: "\(id!).jpg")
    }
    
    @objc func modButtonClicked() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(toolBar)

        title = bookList?.title
        detailPageSet()
        toolBarSet()
        
        memoTextView.delegate = self
        memoTextView.text = placeholderText
        tabBarController?.tabBar.isHidden = true
        
        toolBar.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view)
            make.bottom.equalTo(view)
            make.height.equalTo(50)
        }
        
    }
    
    //MARK: - define method
    @IBAction func gestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func detailPageSet() {
    
        let url = URL(string: bookList!.thumbnail)
        bookImage.kf.setImage(with: url)
        bookTitleLabel.text = bookList?.title
        bookDateLabel.text = bookList?.datetime
        bookPriceLabel.text = bookList?.sale_price
        bookRelatedInfo.text = bookList?.bookRelatedInfo
        bookOverViewLabel.text = bookList?.contents
    }
    
}

//MARK: - extension
extension DetailViewController:UITextViewDelegate {
    
    //편집 시작 시점
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }

    //편집을 끝내는 시점
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }

    }
}



