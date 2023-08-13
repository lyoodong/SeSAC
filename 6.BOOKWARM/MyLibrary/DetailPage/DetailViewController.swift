//
//  DetailViewController.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//

import Kingfisher
import UIKit

class DetailViewController: UIViewController {
    //MARK: - property
    static let IDF = "DetailViewController"
    lazy var movieTitle:String = ""
    lazy var placeholderText:String = "텍스트 입력"
    var bookList:Book?
    
    //MARK: - UI porperety
    @IBOutlet var bookImage: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookRelatedInfo: UILabel!
    @IBOutlet var bookDateLabel: UILabel!
    @IBOutlet var bookPriceLabel: UILabel!
    @IBOutlet var bookOverViewLabel: UILabel!
    @IBOutlet var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = bookList?.title
        detailPageSet()
        
        memoTextView.delegate = self
        memoTextView.text = placeholderText
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



