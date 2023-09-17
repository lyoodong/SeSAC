//
//  SecondViewController.swift
//  DiffableExample
//
//  Created by Dongwan Ryoo on 2023/09/17.
//

import UIKit
import SnapKit

enum Sections: Int, CaseIterable {
    case first
    case second
    case third
}

class SecondViewController: UIViewController {
    
    var list1 = ["공지사항", "실험실", "버전 정보"]
    var list2 = ["개인/보인", "알림", "채팅", "멀티프로필"]
    var list3 = ["고객센터/도움말"]
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    //2. 셀 생성
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    
    //4. UICollectionViewDiffableDataSource객체 생성
    var dataSource: UICollectionViewDiffableDataSource<Sections, String>!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cellRegistrationSet()
        dataSourceSet()
        snapshotSet()
    }
    
    //1. 레이아웃 생성
    func layout() -> UICollectionViewLayout {
        let configure = UICollectionLayoutListConfiguration(appearance: .grouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configure)
        
        return layout
    }
    
    //3. cellRegistration 등록
    func cellRegistrationSet() {
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.textProperties.color = .black
            
            cell.contentConfiguration = content
        })
    }
    
    //5. dataSourceSet() 생성, cellforitemAt 변환
    func dataSourceSet() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    //8. snapshot으로 numofSection 대체
    func snapshotSet() {
        var snapShot = NSDiffableDataSourceSnapshot<Sections, String>()
        snapShot.appendSections(Sections.allCases)
        snapShot.appendItems(list1, toSection: Sections.first)
        snapShot.appendItems(list2, toSection: Sections.second)
        snapShot.appendItems(list3, toSection: Sections.third)
        
        dataSource.apply(snapShot)
    }


}
