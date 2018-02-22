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
  
  private let realm: Realm
  
  init() {
    var config = Realm.Configuration()
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    print(documentURL)
    config.fileURL = documentURL.appendingPathComponent("WordBook.realm")
    config.objectTypes = [WordRecord.self, WordToday.self]
    config.schemaVersion = 0
    realm = try! Realm(configuration: config)
  }
  
  func get(WordRecord id: Int) -> WordRecord? {
    return realm.object(ofType: WordRecord.self, forPrimaryKey: id)
  }
  
  // MARK: Daily Check
  func dailyCheck() {
    
  }
  
  private func supplyWorkbench() {
    let workbenchCount = UserDataManager.countOfWorkbench
    let currentCount = realm.objects(WordRecord.self).filter("level != 0 AND level != 5").count
    if currentCount < workbenchCount {
      let need = workbenchCount - currentCount
      var wordReadyToLearn = Array(realm.objects(WordRecord.self).filter("level = 0"))
      if need < wordReadyToLearn.count {
        wordReadyToLearn = wordReadyToLearn.randomPick(n: need)
      }
      for word in wordReadyToLearn {
        word.state = .ready
      }
    }
  }
  
  private func refreshWordToday() {
    let amountToLearnEveryday = UserDataManager.countToLearnEveryday
    var workbench = Array(realm.objects(WordRecord.self).filter("level != 0 AND level != 5"))
    let wordsToday = realm.objects(WordToday.self)
    realm.delete(wordsToday)
    if workbench.count > amountToLearnEveryday {
      workbench = workbench.randomPick(n: amountToLearnEveryday)
    }
    for word in workbench {
      let wordToday = WordToday()
      wordToday.item = word
      realm.add(wordToday)
    }
  }
  
  // MARK: Word Operation
  func AddOrForget(entryID: Int) {
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
  
  func pass(entryID: Int) {
    
  }
}
