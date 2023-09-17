//
//  ViewController.swift
//  DiffableExample
//
//  Created by Dongwan Ryoo on 2023/09/17.
//

import UIKit
import SnapKit

//6. 섹션 생성
enum Section: Int, CaseIterable {
    case first
    case second
}

class ViewController: UIViewController {
    
    //2. 컬랙션 뷰 생성
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    //3. cell데이터 타입 결정 및 등록
    var cellRagistration: UICollectionView.CellRegistration<UICollectionViewListCell, Model>!
    
    //헤더와 푸터 cell 타입 등록 및 결정
    var headerRegistration: UICollectionView.SupplementaryRegistration<UICollectionViewListCell>!
    var footerRegistration: UICollectionView.SupplementaryRegistration<UICollectionViewListCell>!
    
    //5. UICollectionViewDiffableDataSource객체 생성
    var dataSource: UICollectionViewDiffableDataSource<Section, Model>!
    
    var list: [Model] = [Model(title: "방해금지모드", imageName: "moon.fill"), Model(title: "수면", imageName: "bed.double.fill"), Model(title: "업무", imageName: "clipboard.fill"), Model(title: "개인 시간", imageName: "person.fill")]
    var list2: [Model] = [Model.init(title: "모든 기기에서 공유", imageName: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        collectionViewCellSet()
        dataSourceSet()
        snapshotSet()
//        headerSet()
//        footerSet()
    }
    
    //1. 기본 레이아웃 설정
    func layout() -> UICollectionViewLayout {
        var configure = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        //header와 footer view 선언
//        configure.headerMode = .supplementary
//        configure.footerMode = .supplementary
        
        let layout = UICollectionViewCompositionalLayout.list(using: configure)
        
        return layout
    }
    
    //4. cellRagistration 설정
    func collectionViewCellSet() {
        cellRagistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.sidebarCell()
            
            content.text = itemIdentifier.title
            content.textProperties.color = .black
            
            if indexPath.row == 2 {
                content.secondaryText = "9:00 ~ 12:00"
            }
            
            content.image = itemIdentifier.image
            content.imageProperties.tintColor = self.imageColorBySectoion(indextPath: indexPath)
            
            
            cell.contentConfiguration = content
            cell.accessories = [.disclosureIndicator(), .label(text: self.accessoriesTextSet(indextPath: indexPath))]
            
            let backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            
            cell.backgroundConfiguration = backgroundConfig
            
        })
    }
    
    //헤더 등록
//    func headerSet() {
//        headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader, handler: {  supplementaryView, elementKind, indexPath in
//
//
//
//            var configuration = supplementaryView.defaultContentConfiguration()
//            configuration.text = self.list[indexPath.row].title
//
//            supplementaryView.contentConfiguration = configuration
//
//        })
//    }
//
//    //푸터 등록
//    func footerSet() {
//        footerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader, handler: { supplementaryView, elementKind, indexPath in
//
//            var configuration = supplementaryView.defaultContentConfiguration()
//            configuration.text = "d"
//
//            supplementaryView.contentConfiguration = configuration
//
//        })
//    }
    
    
    
    //7. dataSourceSet() 생성, cellforitemAt 변환
    func dataSourceSet() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRagistration, for: indexPath, item: itemIdentifier)
            
//            self.dataSource.supplementaryViewProvider = {
//                (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
//
//                if elementKind == UICollectionView.elementKindSectionHeader {
//
//                    return self.collectionView.dequeueConfiguredReusableSupplementary(
//                        using: (self.headerRegistration)!, for: indexPath)
//
//                } else {
//
//                    return self.collectionView.dequeueConfiguredReusableSupplementary(
//                        using: (self.footerRegistration)!, for: indexPath)
//                }
//            }
            
            return cell
        })
    }
    

    
    //8. snapshot으로 numofSection 대체
    func snapshotSet() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Model>()
        snapShot.appendSections(Section.allCases)
        snapShot.appendItems(list, toSection: Section.first)
        snapShot.appendItems(list2, toSection: Section.second)
        
        dataSource.apply(snapShot)
    }
    
    func imageColorBySectoion(indextPath: IndexPath) -> UIColor {
        
        switch indextPath.row {
        case 0:
            return .purple
        case 1:
            return .orange
        case 2:
            return .green
        case 3:
            return .blue
        default:
            return .black
        }
    }
    
    func accessoriesTextSet(indextPath: IndexPath) -> String {
        
        if indextPath.section == 0 {
            switch indextPath.row {
            case 0:
                return "켬"
            case 1:
                return ""
            case 2:
                return ""
            case 3:
                return "설정"
            default:
                return ""
            }
        } else {
            return ""
        }
    
    }
}





