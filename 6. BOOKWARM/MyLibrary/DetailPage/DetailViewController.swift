//
//  DetailViewController.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//

import UIKit

struct MovieInfoDetail {
    var movieTitle:String
    var rate:Double
    var overview:String
}

class DetailViewController: UIViewController {
    
    static let IDF = "DetailViewController"
    
    lazy var movieTitle:String = ""
    var movieInfo = MovieInfoDetail(movieTitle: "", rate: 0, overview: "")
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var overViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = movieInfo.movieTitle
        detailPageSet()
    }
    
    func detailPageSet() {
        movieImage.image = UIImage(named: "\(movieInfo.movieTitle)")
        titleLabel.text = movieInfo.movieTitle
        rateLabel.text = movieInfo.movieTitle
        overViewLabel.text = movieInfo.overview
    }
    
}
