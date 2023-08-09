//
//  LookAroundViewController.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/08/02.
//

import UIKit

class LookAroundViewController: UIViewController {

    //MARK: - ui porperty
    
    @IBOutlet var tableViewHeaderView: UIView!
    @IBOutlet var popularTableView: UITableView!
    @IBOutlet var headerCollectionView: UICollectionView!
    
    //MARK: - porperty
    
    let dummydata = [1,2,3,4,5]
    private let movieinfo = MovieInfo()
    
    //MARK: - define Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewLayout()
        collectionViewSet(headerCollectionView)
        tableViewSet(popularTableView)
        registerCollectionViewCell()
        registerTableViewCell()
    }
    
    func collectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing:CGFloat = 4
        let size = CGSize(width: (UIScreen.main.bounds.width - (spacing * 4)) / 4 , height: UIScreen.main.bounds.height)
        layout.itemSize = size
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        
        headerCollectionView.collectionViewLayout = layout
    }

    func registerCollectionViewCell() {
        let nib = UINib(nibName: HeaderCollectionViewCell.IDF, bundle: nil)
        headerCollectionView.register(nib, forCellWithReuseIdentifier: HeaderCollectionViewCell.IDF)
    }
    
    func registerTableViewCell() {
        let nib = UINib(nibName: LookAroundTableViewCell.IDF, bundle: nil)
        popularTableView.register(nib, forCellReuseIdentifier: LookAroundTableViewCell.IDF)
    }
    
    func collectionViewSet(_ view:UICollectionView) {
        view.delegate = self
        view.dataSource = self
    }
    

    func tableViewSet(_ view:UITableView) {
        view.delegate = self
        view.dataSource = self
        view.tableHeaderView = tableViewHeaderView
        view.rowHeight = (popularTableView.bounds.height - tableViewHeaderView.bounds.height) / 4
    }
}

//MARK: - extension

extension LookAroundViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    //MARK: - collectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieinfo.movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.IDF, for: indexPath) as! HeaderCollectionViewCell
        
        let image = UIImage(named: "\(movieinfo.movie[indexPath.row].title)")
        cell.bookImage.image = image
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: DetailViewController.IDF) as! DetailViewController
        
        let row = movieinfo.movie[indexPath.row]
//        vc.movieInfo = row
        
        present(vc, animated: true)
    }
    
    //MARK: - tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieinfo.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LookAroundTableViewCell.IDF) as! LookAroundTableViewCell
        
        let row = movieinfo.movie[indexPath.row]
        cell.configureCell(row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: DetailViewController.IDF) as! DetailViewController
        
        let row = movieinfo.movie[indexPath.row]
//        vc.movieInfo = row
        
        present(vc, animated: true)
    }
    
}

