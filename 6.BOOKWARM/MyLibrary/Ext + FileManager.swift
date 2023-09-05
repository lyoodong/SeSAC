//
//  Ext + FileManager.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/09/05.
//

import UIKit
import Realm

extension UIViewController {
    
    func saveImageToDocumet(fileName:String, image:UIImage) {
        //1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return }
        
        //2. 저장할 위치 설정
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        //3. 이지미 변환
        guard let data = image.jpegData(compressionQuality: 0.5)
        else { return }
        
        //4. 이미지 저장
        do{
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
         
    }
    
    func loadImageFromDocument(fileName:String) -> UIImage {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "star.fill")! }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)!
        } else {
            return UIImage(systemName: "star.fill")!
        }
        
        
    }
    
    func removeImageFromDocumet(fileName:String) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
    
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
    }
    
}
