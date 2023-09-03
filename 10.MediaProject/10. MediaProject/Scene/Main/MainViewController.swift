//
//  ViewController.swift
//  10. MediaProject
//
//  Created by Dongwan Ryoo on 2023/08/11.
//

import Alamofire
import Kingfisher
import UIKit

class MainViewController: UIViewController {

    //MARK: - Property
    var movie:TMDBData?
    
    //MARK: - UI porperty
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var trendTableView: UITableView!
    @IBOutlet var mediaButtonType: UIButton!
    
    //MARK: - Define method
    override func viewDidLoad() {
        
        super.viewDidLoad()
        callNetwork()
        trendTableViewSet(trendTableView)
        mediaButtonType.addTarget(self, action: #selector(mediaButtonTypeClicked), for: .touchUpInside)
    }
    
    @objc
    func mediaButtonTypeClicked() {
        let alert = UIAlertController(title: "유형을 선택하세요.", message: nil, preferredStyle: .actionSheet)
    }
    
    func callNetwork() {
        APIManager.shared.callRequestCodable(videoType: .movie) { TMDBData in
            self.movie = TMDBData
            DispatchQueue.main.async {
                self.trendTableView.reloadData()
            }
        }
        
    }
    
    func trendTableViewSet(_ tableView:UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UIScreen.main.bounds.height / 5
        registerCell()
    }
    
    func registerCell() {
        let nib = UINib(nibName: MainTableViewCell.IDF, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: MainTableViewCell.IDF)
    }
    
}

extension MainViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.IDF) as? MainTableViewCell
        else { return UITableViewCell()}
        
        guard let movieData = movie else { return UITableViewCell() }
        let row = movieData.results[indexPath.row]
        
        if let url = URL(string: "https://image.tmdb.org/t/p/original/" + row.posterPath ) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.posterImageView.image = UIImage(data: data)
                        
                    }
                }
            }
        }
        
        cell.titleLabel.text = "제목: " + row.title
        cell.averageRateLabel.text = "\(row.voteAverage)"
        cell.releaseDateLabel.text = "개봉일: " + row.releaseDate
        
        UIView.animate(withDuration: 1) {
            //기존에 스토리보드의 조건을 무시하고 새로 오토레이아웃 조거을 추가하기 위해 필요한 코드
            cell.avarageRateView.translatesAutoresizingMaskIntoConstraints = true
            //뷰의 길이
            let viewWidth:CGFloat = cell.bounds.width - cell.posterImageView.bounds.width - 56
            //평점 퍼센티지화
            let voteAveragePercnet:CGFloat = row.voteAverage / 10
            //평점의 정도를 나타낼 막대바를 viewWidth의 크기에 비례해서 계산
            cell.avarageRateView.frame.size.width = viewWidth * voteAveragePercnet
            print(cell.avarageRateView.frame.size.width)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: DetailViewController.IDF) as! DetailViewController
        
        guard let movieData = movie else { return }
        vc.movie = movieData.results[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

