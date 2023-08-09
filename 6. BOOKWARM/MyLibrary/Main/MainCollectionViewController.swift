//
//  MainCollectionViewController.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//
import Alamofire
import SwiftyJSON
import UIKit

class MainCollectionViewController: UICollectionViewController {
    //MARK: - property
    var movieData = MovieInfo() {
        didSet {
            collectionView.reloadData()
            print("뷰 리로드")
        }
    }
    
    var bookList:[Book] = [] {
        didSet {
            collectionView.reloadData()
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
    
    
    @objc
    func likeButtonTapped(_ sender:UIButton) {
        let index = sender.tag
        bookList[index].like.toggle()
    }
    
    func showAlert(_ title:String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .cancel) { _ in self.movieData = MovieInfo()}
        
        alert.addAction(action)
        
        present(alert, animated: true)
        searchBar.text = ""
    }
    
    func callRequest(query:String) {
        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)"
        
        AF.request(url, method: .get, headers: APIKey.kakao).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let resultAry = json["documents"].arrayValue
                
                for item in resultAry {
                    let thumbnail = item["thumbnail"].stringValue
                    let title = item["title"].stringValue
                    let authors = item["authors"].arrayValue.map { $0.stringValue }
                    let publisher = item["publisher"].stringValue
                    let contents = item["contents"].stringValue
                    let datetime = item["datetime"].stringValue
                    let sale_price = item["sale_price"].stringValue
                    let url = item["url"].stringValue
                    
                    let book = Book(thumbnail: thumbnail, title: title, authors: authors, publisher: publisher, contents: contents, datetime: datetime, sale_price: sale_price, url: url)
                    
                    self.bookList.append(book)
                }
                
                print(self.bookList)
            
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

//MARK: - extension
extension MainCollectionViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        bookList.removeAll()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        callRequest(query: searchText)
        print("검색 성공")
        
        
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        //영어와 달리 한글을 한 글자 단위로 검색하는데 실패 -> 오류 해결 요망
//        if searchBar.text?.isEmpty == true {
//            movieData = MovieInfo()
//        }
//    }
    
}

extension MainCollectionViewController  {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return bookList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.IDF, for: indexPath) as! MainCollectionViewCell
        let row = bookList[indexPath.row]
        let index = indexPath.row
        cell.cellSet(row: row, index: index)
        
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier:DetailViewController.IDF ) as? DetailViewController else { return }
        
        let row = indexPath.row
        vc.bookList = bookList[row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}


