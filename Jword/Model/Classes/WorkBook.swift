//
//  WorkBook.swift
//  Jword
//
//  Created by usagilynn on 2/9/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import Foundation
import RealmSwift


final class WordRecord: Object {
  
  @objc dynamic var entryId: Int = 0
  @objc dynamic var level: Int = 0
  @objc dynamic var needCheck: Bool = false
  @objc dynamic var lastUpdate: Date = Date()
  @objc dynamic var note: String? = nil
  
  override static func primaryKey() -> String? {
    return "entryId"
  }
  
  func addNote(_ note: String) {
    self.note = note
  }
  
  func deleteNote() {
    note = nil
  }
  
  func forget() {
    level /= 2
    needCheck = true
    lastUpdate = Date()
  }
  
  func pass() {
    if level != 5 {
      level += 1
    } else {
      needCheck = false
    }
    lastUpdate = Date()
  }
  
}

// 50 word
// need UserDefault to record Date of wordToday and present progress
final class WordToday: Object {
  
  @objc dynamic var item: WordRecord? = nil
  @objc dynamic var learnt: Int = 1
  
  func forget() {
    learnt = 0
    item?.forget()
  }
  func pass() {
    learnt += 1
    item?.pass()
  }
}
