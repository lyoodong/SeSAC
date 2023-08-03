//
//  MainCollectionViewController.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//

import UIKit

class MainCollectionViewController: UICollectionViewController {
    //MARK: - property
    var movieData = MovieInfo() {
        didSet {
            collectionView.reloadData()
            print("뷰 리로드")
        }
    }
    //MARK: - UI porperety
    let searchBar = UISearchBar()
    
    //MARK: - define method
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar(searchBar)
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
    
    func setSearchBar(_ searchBar:UISearchBar) {
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        searchBar.delegate = self
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
    
    func showAlert(_ title:String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .cancel) { _ in self.movieData = MovieInfo()}
        
        alert.addAction(action)
        
        present(alert, animated: true)
        searchBar.text = ""
    }
    
}

//MARK: - extension
extension MainCollectionViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        movieData = MovieInfo()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        var searchedMovie:[Movie] = []
        
        for item in movieData.movie {
            if item.title.contains(searchText) {
                searchedMovie.append(item)
            }
        }
        
        if searchedMovie.isEmpty {
            showAlert("검색 결과가 없습니다.")
        } else {
            movieData.movie = searchedMovie
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //영어와 달리 한글을 한 글자 단위로 검색하는데 실패 -> 오류 해결 요망
        if searchBar.text?.isEmpty == true {
            movieData = MovieInfo()
        }
    }

}

