//
//  UserDataManager.swift
//  Jword
//
//  Created by usagilynn on 2/9/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import Foundation
import RealmSwift

final class UserDataManager {
  
  static let shared = UserDataManager()
  
  let realm: Realm
  
  static var countToLearnEveryday: Int {
    get {
      return UserDefaults.standard.integer(forKey: "amountToLearnEveryday")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "amountToLearnEveryday")
    }
  }
  
  static var countOfWorkbench: Int {
    return Int(Double(countToLearnEveryday) * 1.4)
  }
  
  static var lastUpdateDate: Date {
    get {
      return UserDefaults.standard.value(forKey: "lastUpdateDate") as! Date
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "lastUpdateDate")
    }
  }
  
  private init() {
    // Prepare realm
    var config = Realm.Configuration()
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    print(documentURL)
    config.fileURL = documentURL.appendingPathComponent("WordBook.realm")
    config.objectTypes = [WordRecord.self, WordToday.self]
    config.schemaVersion = 0
    realm = try! Realm(configuration: config)
  }
  
}
