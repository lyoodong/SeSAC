//
//  MovieTableViewCell.swift
//  MovieTableView
//
//  Created by Dongwan Ryoo on 2023/07/29.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let IDF = "MovieTableViewCell"

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    
    func propertyToString(_ label:Any) -> String {
        return "\(label)"
    }
    
    
    func configureCell(row:Movie) {
        
        posterImageView.image = UIImage(named: "\(row.title)")
        titleLabel.text = row.title
        releaseDateLabel.text = row.releaseDate
        runtimeLabel.text = propertyToString(row.runtime)
        rateLabel.text = propertyToString(row.rate)
        summaryLabel.text = row.overview
        
        print(row.title)
        
    }
    
    
}
