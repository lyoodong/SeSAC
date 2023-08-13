//
//  MainTableViewCell.swift
//  10. MediaProject
//
//  Created by Dongwan Ryoo on 2023/08/11.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    //MARK: - UI property
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var avarageRateView: UIView!
    @IBOutlet var averageRateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
