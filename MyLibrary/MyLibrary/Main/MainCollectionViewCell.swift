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
    
    func cellSet(row:Movie) {
        let movieTitle = row.title
        
        titleLable.text = movieTitle
        rateLabel.text = "\(row.rate)"
        posterImageView.image = UIImage(named: movieTitle)
        backgroundColor = UIColor.random()
        layer.cornerRadius = 10
    }
    
    
    
  
}
