//
//  DictManager.swift
//  Jword
//
//  Created by usagilynn on 2/8/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import Foundation
import RealmSwift

protocol JMDictProtocol {
  func getEntry(id: Int) -> JMEntry
  func getEntries(IDs: [Int]) -> [JMEntry]
  func search(kanji: String) -> [JMEntry]
  func search(hiragana: String) -> [JMEntry]
  func search(english: String) -> [JMEntry]
}

struct DictManager: JMDictProtocol {

  static let shared = DictManager()
  
  private let realm: Realm
  
  private init() {
    var config = Realm.Configuration()
    config.fileURL = Bundle.main.url(forResource: "JMDict", withExtension: "realm")
    config.readOnly = true
    config.objectTypes = [JMEntry.self, JMSense.self, TNKExample.self]
    config.schemaVersion = 2
    realm = try! Realm(configuration: config)
  }
  
  func getEntry(id: Int) -> JMEntry {
    return realm.object(ofType: JMEntry.self, forPrimaryKey: id)!
  }
  func getEntries(IDs: [Int]) -> [JMEntry] {
    return IDs.map(getEntry(id:))
  }
  
  func search(kanji: String) -> [JMEntry] {
    let res = realm.objects(JMEntry.self).filter("kanji contains %@", kanji)
    return res.sorted(by: entrySorter(_:_:))
  }
  
  func search(hiragana: String) -> [JMEntry] {
    let res = realm.objects(JMEntry.self).filter("reading contains %@", hiragana)
    return res.sorted(by: entrySorter(_:_:))
  }
  
  func search(english: String) -> [JMEntry] {
    let res = realm.objects(JMEntry.self).filter("english contains %@", english)
    return Array(res.sorted(byKeyPath: "priority"))
  }
  
  private func entrySorter(_ e1: JMEntry, _ e2: JMEntry) -> Bool {
    if e1.kanji.count != e2.kanji.count {
      return e1.kanji.count < e2.kanji.count
    } else if e1.priority != e2.priority {
      return e1.priority < e2.priority
    } else {
      return e1.id < e2.id
    }
  }
  
}
