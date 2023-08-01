//
//  MainCollectionViewCell.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    
    static let IDF = "MainCollectionViewCell"
    
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    func cellSet(row:Movie, index:Int) {
        let movieTitle = row.title
        
        titleLable.text = movieTitle
        rateLabel.text = "\(row.rate)"
        posterImageView.image = UIImage(named: movieTitle)
        backgroundColor = row.color
        layer.cornerRadius = 10
        
        likeButton.tag = index
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .systemPink

        let defaultImage = UIImage(systemName: "heart")
        let fillImage = UIImage(systemName: "heart.fill")
        if row.like == false  {
            likeButton.setImage(defaultImage, for: .normal)
        } else {
            likeButton.setImage(fillImage, for: .normal)
        }
    
    }

}
