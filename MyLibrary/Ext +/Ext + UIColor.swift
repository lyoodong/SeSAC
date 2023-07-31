//
//  Ext + UIColor.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//

import UIKit

extension UIColor {
    
    static func random() -> UIColor {
        
        let red = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: blue, blue: green, alpha: 1)
    }
    
}
