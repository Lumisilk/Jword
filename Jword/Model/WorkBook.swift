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
  
  enum Level: Int {
    case wait = 0
    case ready = 1
    case familiar = 2
    case know = 3
    case spell = 4
    case master = 5
  }
  
  // MARK: Properties for realm
  @objc dynamic var entryId: Int = 0
  @objc dynamic var needCheck: Bool = false
  @objc dynamic var lastUpdate: Date = Date()
  @objc dynamic var note: String? = nil
  @objc dynamic private var privateLevel: Int = 0
  
  // MARK: Properties for Jword
  var level: Level {
    get { return Level(rawValue: privateLevel)! }
    set { privateLevel = newValue.rawValue }
  }
  
  override static func primaryKey() -> String? {
    return "entryId"
  }
  
  func forget() {
    if privateLevel != 1 {
      privateLevel /= 2
    }
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
  
  func tooEasy() {
    privateLevel = 5
    needCheck = false
    lastUpdate = Date()
  }
  
  // MARK: Static Query Statement
  static let wordRecordsInWorkbench = "privateLevel != 0 AND privateLevel != 5"
  static let wordRecordsWaiting = "privateLevel = 0"
}

final class WordToday: Object {
  
  enum State: Int {
    case forgotten = -1
    case wait = 0
    case learnt = 1
  }
  
  @objc dynamic var entryId: Int = 0
  @objc dynamic private var privateState: Int = 0
  var state: State {
    get { return State(rawValue: privateState)! }
    set { privateState = newValue.rawValue }
  }
  
  override static func primaryKey() -> String? {
    return "entryId"
  }
  
  func forget() {
    privateState = -1
  }
  func pass() {
    if privateState < 1 {
      privateState += 1
    }
  }
  
  static let wordTodayToLearn = "privateState != 1"
}
