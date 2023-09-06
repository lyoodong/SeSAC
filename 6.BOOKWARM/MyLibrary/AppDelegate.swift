//
//  AppDelegate.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/07/31.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration(schemaVersion: 3) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 { }
            
            if oldSchemaVersion < 2 {
                migration.renameProperty(onType: RealmModel.className(), from: "title", to: "booktitle")
            }
            
            if oldSchemaVersion < 3 {
                migration.enumerateObjects(ofType: RealmModel.className()) { oldObject, newObject in
                    guard let new = newObject, let old = oldObject else { return }
                    new["bookMaker"] = "\(old["publisher"]) + \(old["authors[0]"])입니다."
                }
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        //        let data = realm.objects(RealmModel.self)
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

