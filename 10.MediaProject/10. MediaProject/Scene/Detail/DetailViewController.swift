//
//  DetailViewController.swift
//  10. MediaProject
//
//  Created by Dongwan Ryoo on 2023/08/11.
//

import Alamofire
import SwiftyJSON
import UIKit

class DetailViewController: UIViewController {
    var movie:Result?
    var castingList:CastData?

    //MARK: - UI porperty
    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var averageRateLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var castingCollectionView: UICollectionView!
    
    //MARK: - Define method
    override func viewDidLoad() {
        super.viewDidLoad()
        callrequest()
        castingCollectionViewSet(castingCollectionView)
        uiSet()
    }
    
    func castingCollectionViewSet(_ collectionView:UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout
        
        registerCell()
    }
    
    func registerCell() {
        let nib = UINib(nibName: DetailCollectionViewCell.IDF, bundle: nil)
        castingCollectionView.register(nib, forCellWithReuseIdentifier: DetailCollectionViewCell.IDF)
    }
    
    func uiSet() {
        
        if let url = URL(string: "https://image.tmdb.org/t/p/original/" + movie!.backdropPath ) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        self.titleImageView.image = UIImage(data: data)
                    }
                    
                }
            }
        }
        
        titleLabel.text = movie?.title
        releaseDateLabel.text = movie?.releaseDate
        averageRateLabel.text = "\(movie!.voteAverage)"
        overviewLabel.text = movie?.overview
    
    }
    
    func callrequest() {
        APIManager.shared.callRequestCadableCast(movie!.id) { CastData in
            self.castingList = CastData
            self.castingCollectionView.reloadData()
        }
    }

}

extension DetailViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let castinglist = castingList else { return 0 }
        
        return castinglist.cast.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.IDF, for: indexPath) as? DetailCollectionViewCell
        else { return UICollectionViewCell()}
        
        guard let castinglist = castingList else { return UICollectionViewCell() }
        
        if let url = URL(string: "https://image.tmdb.org/t/p/original/" + (castinglist.cast[indexPath.row].profilePath ?? "")) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.castImageView.image = UIImage(data: data)
                        cell.castNameLabel.text = castinglist.cast[indexPath.row].originalName
                    }
                }
            }
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = collectionView.bounds.height
        let size = CGSize(width: length, height: length)
        
        return size
    }

}
