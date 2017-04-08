//
//  Realm+MTExtension.swift
//  MobileTrading
//
//  Created by Nguyen Minh on 4/8/17.
//  Copyright © 2017 AHDEnglish. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

//Write helper
extension Realm {
    
    func safeAdd(object: Object) {
        self.add(object, update: true)
    }
    
    public class func updateData(_ block: ((Realm) throws -> Void)) {
        do {
            if let realm = try? Realm() {
                realm.beginWrite()
                try block(realm)
                try realm.commitWrite()
            } else {
                Realm.removeOldRealmDataFile()
                //Re-try again
                let realm = try! Realm()
                realm.beginWrite()
                try block(realm)
                try realm.commitWrite()
            }
        } catch {
            print("Error on write realm: \(error.localizedDescription)")
        }
    }
    
    fileprivate class func removeOldRealmDataFile() {
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
            } catch {
                print("Still failed when try to remove old realm data files.")
            }
        }
    }
    
    public class func readData(_ block: ((Realm) throws -> Void)) {
        do {
            if let realm = try? Realm() {
                try block(realm)
            } else {
                Realm.removeOldRealmDataFile()
                //Re-try again
                let realm = try! Realm()
                try block(realm)
            }
        } catch {
            print("Error on read realm: \(error.localizedDescription)")
        }
    }
}
