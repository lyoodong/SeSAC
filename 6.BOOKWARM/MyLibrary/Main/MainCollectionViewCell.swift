//
//  MainCollectionViewCell.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//

import UIKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {
    //MARK: - property
    static let IDF = "MainCollectionViewCell"
    
    //MARK: - UI porperety
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    //MARK: - define method
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.tintColor = .systemPink
        likeButton.setTitle("", for: .normal)
        layer.cornerRadius = 10
    }
    
    func cellSet(row:Book, index:Int) {
        titleLable.text = row.title
        
        let url = URL(string: row.thumbnail)
        posterImageView.kf.setImage(with: url)
        backgroundColor = row.color
        likeButton.tag = index
    
        let defaultImage = UIImage(systemName: "heart")
        let fillImage = UIImage(systemName: "heart.fill")
        if row.like == false  {
            likeButton.setImage(defaultImage, for: .normal)
        } else {
            likeButton.setImage(fillImage, for: .normal)
        }
    
    }

}
