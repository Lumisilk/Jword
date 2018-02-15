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
  
  enum State: Int {
    case wait = 0
    case ready = 1
    case familiar = 2
    case know = 3
    case spell = 4
    case master = 5
  }
  
  @objc dynamic var entryId: Int = 0
  @objc dynamic var needCheck: Bool = false
  @objc dynamic var lastUpdate: Date = Date()
  
  @objc dynamic private var privateLevel: Int = 0
  var state: State {
    get {
      return State(rawValue: privateLevel)!
    }
    set {
      privateLevel = newValue.rawValue
    }
  }
  
  override static func primaryKey() -> String? {
    return "entryId"
  }
  
  func forget() {
    privateLevel /= 2
    needCheck = true
    lastUpdate = Date()
  }
  
  func pass() {
    if privateLevel != 5 {
      privateLevel += 1
    } else {
      needCheck = false
    }
    lastUpdate = Date()
  }
  
}


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
