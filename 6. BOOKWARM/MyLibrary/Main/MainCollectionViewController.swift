//
//  MainCollectionViewController.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//

import UIKit

class MainCollectionViewController: UICollectionViewController {

    var movieData = MovieInfo() {
        didSet {
            collectionView.reloadData()
            print("뷰 리로드")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewlayout()
        registerCell()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchViewController.IDF)
        
        let nav = UINavigationController(rootViewController: vc )
        nav.modalTransitionStyle = .coverVertical
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func registerCell() {
        let nib = UINib(nibName: MainCollectionViewCell.IDF, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: MainCollectionViewCell.IDF)
    
    }
    
    func setCollectionViewlayout() {
        let spacing:CGFloat = 20
        let viewWidth = self.view.bounds.width
        let width = ((viewWidth - ( spacing * 3 )) / 2)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        collectionView.collectionViewLayout = layout
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movieData.movie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.IDF, for: indexPath) as! MainCollectionViewCell
        
        let row = movieData.movie[indexPath.row]
        let index = indexPath.row
        cell.cellSet(row: row,index: index)
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier:DetailViewController.IDF ) as? DetailViewController else { return }
        
        let row = movieData.movie[indexPath.row]
        vc.movieInfo = row
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func likeButtonTapped(_ sender:UIButton) {
        let index = sender.tag
        movieData.movie[index].like.toggle()
        print(movieData.movie[index].like)
    }
    
}

