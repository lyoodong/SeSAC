//
//  LookAroundTableViewCell.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/08/02.
//

import UIKit

class LookAroundTableViewCell: UITableViewCell {
    //MARK: - type property
    static let IDF = "LookAroundTableViewCell"
    
    //MARK: - UI property
    
    @IBOutlet var bookImage: UIImageView!
    @IBOutlet var bookTitle: UILabel!
    @IBOutlet var bookReleaseDate: UILabel!
    
    //MARK: - define method
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookImage.contentMode = .scaleAspectFill
    }
    
    func configureCell(_ row:Movie) {
        let image = UIImage(named: "\(row.title)")
        
        bookImage.image = image
        bookReleaseDate.text = "\(row.releaseDate)"
        bookTitle.text = row.title
    }

    
    
}
