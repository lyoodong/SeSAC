//
//  HeaderCollectionViewCell.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/08/02.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    //MARK: - type property
    static let IDF = "HeaderCollectionViewCell"
    
    //MARK: - UI property
    @IBOutlet var bookImage: UIImageView!
    
    //MARK: - define method
    override func awakeFromNib() {
        super.awakeFromNib()
        bookImage.contentMode = .scaleAspectFit
    }

}
