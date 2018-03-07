//
//  WordBookManager.swift
//  Jword
//
//  Created by usagilynn on 2/9/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import Foundation
import RealmSwift

final class BookManager {
  
  static let shared = BookManager()
  
  let realm: Realm
  
  private init() {
    var config = Realm.Configuration()
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    print(documentURL)
    config.fileURL = documentURL.appendingPathComponent("WordBook.realm")
    config.objectTypes = [WordRecord.self, WordToday.self]
    config.schemaVersion = 0
    realm = try! Realm(configuration: config)
  }
  
  // MARK: Fetch Method
  func getWordRecord(entryID: Int) -> WordRecord? {
    return realm.object(ofType: WordRecord.self, forPrimaryKey: entryID)
  }
  func getWordToday() -> [WordToday] {
    return Array(realm.objects(WordToday.self))
  }
  
  // MARK: Daily Check
  func dailyCheck() {
    if !Calendar.current.isDate(Date(), inSameDayAs: UserDataManager.lastUpdateDate) {
      supplyWorkbench()
      refreshWordToday()
    }
  }
  
  func supplyWorkbench() {
    let workbenchCount = UserDataManager.countOfWorkbench
    let currentCount = realm.objects(WordRecord.self).filter("privateLevel != 0 AND privateLevel != 5").count
    if currentCount < workbenchCount {
      let need = workbenchCount - currentCount
      var wordReadyToLearn = Array(realm.objects(WordRecord.self).filter("privateLevel = 0"))
      if need < wordReadyToLearn.count {
        wordReadyToLearn = wordReadyToLearn.randomPick(n: need)
      }
      try? realm.write {
        for word in wordReadyToLearn {
          word.state = .ready
        }
      }
    }
  }
  
  func refreshWordToday() {
    try? realm.write {
      let amountToLearnEveryday = UserDataManager.countToLearnEveryday
      var workbench = Array(realm.objects(WordRecord.self).filter("privateLevel != 0 AND privateLevel != 5"))
      let wordsToday = realm.objects(WordToday.self)
      realm.delete(wordsToday)
      if workbench.count > amountToLearnEveryday {
        workbench = workbench.randomPick(n: amountToLearnEveryday)
      }
      for word in workbench {
        let wordToday = WordToday()
        wordToday.entryId = word.entryId
        realm.add(wordToday)
      }
    }
  }
  
  // MARK: Word Operation
  func addOrForget(entryID: Int) {
    try? realm.write {
      if let record = realm.object(ofType: WordRecord.self, forPrimaryKey: entryID) {
        record.forget()
        if let word = realm.object(ofType: WordToday.self, forPrimaryKey: entryID) {
          word.forget()
        }
      } else {
        let newRecord = WordRecord()
        newRecord.entryId = entryID
        realm.add(newRecord)
      }
    }
  }
  
  func pass(entryID: Int) {
    try? realm.write {
      if let record = realm.object(ofType: WordRecord.self, forPrimaryKey: entryID) {
        record.pass()
        if let word = realm.object(ofType: WordToday.self, forPrimaryKey: entryID) {
          word.pass()
        }
      }
    }
  }
  
  func tooEasy(entryID: Int) {
    try? realm.write {
      if let record = realm.object(ofType: WordRecord.self, forPrimaryKey: entryID) {
        record.pass()
        if let word = realm.object(ofType: WordToday.self, forPrimaryKey: entryID) {
          word.pass()
        }
      }
    }
  }
  
  // MARK: Functiton for Test
  func printAmount() {
    let records = realm.objects(WordRecord.self)
    for i in 0...5 {
      let count = records.filter("privateLevel = %@", i).count
      print("level=\(i): \(count)")
    }
  }
}
