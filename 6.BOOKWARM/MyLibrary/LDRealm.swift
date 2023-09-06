//
//  LDRealm.swift
//  MyLibrary
//
//  Created by Dongwan Ryoo on 2023/09/06.
//

import Foundation
import RealmSwift

enum writeType {
    case add
    case update
}

protocol RealmDB {
    func read<T: Object>(object:T.Type) -> Results<T>
    func write<T: Object>(object:T, writetype:writeType)
    func delete<T: Object>(object:T)
    func sort<T: Object>(object:T.Type, byKeyPath: String, ascending:Bool) -> Results<T>
}

class LDRealm:RealmDB {
    static let shared = LDRealm()
    
    init() {}
    
    let realm = try! Realm()
    
    func getRealmLocation() {
        print("=====Realm 경로: ", realm.configuration.fileURL!)
    }
    
    
    func read<T: Object>( object: T.Type) -> Results<T> {
        return realm.objects(object)
    }
    
    func write<T: Object>(object: T, writetype: writeType )  {
        
        switch writetype {
        case .add:
            do {
                try realm.write {
                    realm.add(object)
                }
            } catch {
                print(error)
            }
        case .update:
            do {
                try realm.write {
                    realm.add(object, update: .modified)
                }
            } catch {
                print(error)
            }
            
        }
    }
    
    func delete<T: Object>(object: T)  {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
    
    func sort<T: Object>(object: T.Type, byKeyPath: String, ascending: Bool) -> Results<T>  {
        return realm.objects(object).sorted(byKeyPath: byKeyPath, ascending: ascending)
    }
    
}
