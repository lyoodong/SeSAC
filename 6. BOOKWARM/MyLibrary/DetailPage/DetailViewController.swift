//
//  DetailViewController.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//

import UIKit



class DetailViewController: UIViewController {
    
    static let IDF = "DetailViewController"
    
    lazy var movieTitle:String = ""
    var movieInfo = Movie(title: "", releaseDate: "", runtime: 0, overview: "", rate: 0)
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var overViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = movieInfo.title
        detailPageSet()
    }
    
    func detailPageSet() {
    
        movieImage.image = UIImage(named: "\(movieInfo.title)")
        titleLabel.text = movieInfo.title
        rateLabel.text = "\(movieInfo.rate)"
        overViewLabel.text = movieInfo.overview
    }
    
}

