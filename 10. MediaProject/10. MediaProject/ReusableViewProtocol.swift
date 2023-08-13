//
//  ReusableViewProtocol.swift
//  10. MediaProject
//
//  Created by Dongwan Ryoo on 2023/08/11.
//

import UIKit

protocol IDFProtocol {
    static var IDF:String {get}
}

extension UIViewController:IDFProtocol {
    static var IDF: String {
        return String(describing: self)
    }
}

extension UITableViewCell:IDFProtocol {
    static var IDF: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell:IDFProtocol {
    static var IDF: String {
        return String(describing: self)
    }
}
