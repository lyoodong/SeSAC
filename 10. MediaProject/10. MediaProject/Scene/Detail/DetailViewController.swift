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
    var movie:Movie?
    var castingList:[Cast] = []

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
        castingCollectionViewSet(castingCollectionView)
        uiSet()
        callRequest(movie!.id)
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
    
    func callRequest(_ movie_id:Int) {
    
        let url = "https://api.themoviedb.org/3/movie/\(movie_id)/credits?api_key=\(APIKey.key)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let castAry = json["cast"].arrayValue
                
                for item in castAry{
                    let originalName = item["original_name"].stringValue
                    let profilePath = item["profile_path"].stringValue
                    
                    let casting = Cast(originalName: originalName, profilePath: profilePath)
                    self.castingList.append(casting)
                    self.castingCollectionView.reloadData()
                }
                
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
            
        }
        
    }

}

extension DetailViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return castingList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.IDF, for: indexPath) as! DetailCollectionViewCell
        
        if let url = URL(string: "https://image.tmdb.org/t/p/original/" + castingList[indexPath.row].profilePath) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.castImageView.image = UIImage(data: data)
                        cell.castNameLabel.text = self.castingList[indexPath.row].originalName
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
