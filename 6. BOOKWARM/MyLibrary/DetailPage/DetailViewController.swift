//
//  DetailViewController.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//

import UIKit



class DetailViewController: UIViewController {
    //MARK: - property
    static let IDF = "DetailViewController"
    lazy var movieTitle:String = ""
    lazy var movieInfo = Movie(title: "", releaseDate: "", runtime: 0, overview: "", rate: 0)
    lazy var placeholderText:String = "텍스트 입력"
    
    //MARK: - UI porperety
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var overViewLabel: UILabel!
    @IBOutlet var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = movieInfo.title
        detailPageSet()
        
        memoTextView.delegate = self
        memoTextView.text = placeholderText
    }
    
    //MARK: - define method
    @IBAction func gestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func detailPageSet() {
    
        movieImage.image = UIImage(named: "\(movieInfo.title)")
        titleLabel.text = movieInfo.title
        rateLabel.text = "\(movieInfo.rate)"
        overViewLabel.text = movieInfo.overview
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



