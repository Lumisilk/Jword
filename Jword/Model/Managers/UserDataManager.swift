//
//  UserDataManager.swift
//  Jword
//
//  Created by usagilynn on 2/9/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import Foundation
import RealmSwift

enum UserDataManager {

  static var countToLearnEveryday: Int {
    get {
      let res = UserDefaults.standard.integer(forKey: "amountToLearnEveryday")
      return res == 0 ? 10 : res
    }
    set { UserDefaults.standard.set(newValue, forKey: "amountToLearnEveryday") }
  }
  
  static var countOfWorkbench: Int {
    return Int(Double(countToLearnEveryday) * 1.4)
  }
  
  static var lastUpdateDate: Date? {
    get { return UserDefaults.standard.value(forKey: "lastUpdateDate") as? Date }
    set { UserDefaults.standard.set(newValue, forKey: "lastUpdateDate") }
  }
  
  static private(set) var searchHistory: [Int] {
    get {
      let arr = UserDefaults.standard.array(forKey: "searchHistory") as? [Int] ?? [Int]()
      return arr.reversed()
    }
    set { UserDefaults.standard.set(newValue, forKey: "searchHistory") }
  }
  static func addSearchHistory(entryID: Int) {
    var arr = searchHistory
    arr.insert(entryID, at: 0)
    if arr.count > 20 {
      arr.removeLast()
    }
    searchHistory = arr
  }
  
}
