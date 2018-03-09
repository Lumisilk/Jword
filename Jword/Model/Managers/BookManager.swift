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
  //complete: (_ wordsTodayCount: Int, _ progress: Int) -> ()
  func dailyCheck() {
    let now = Date()
    print(now)
    if !Calendar.current.isDate(now, inSameDayAs: UserDataManager.lastUpdateDate) {
      print("last: \(UserDataManager.lastUpdateDate)")
      supplyWorkbench()
      refreshWordToday()
      UserDataManager.lastUpdateDate = now
      print("freshed")
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
  
  // MARK: Add Vocabulary Book Method
  enum VocabularyBook: String {
    case N1
  }
  func addVocabularyBook(book: VocabularyBook) -> Int {
    var count = 0
    let file = Bundle.main.url(forResource: book.rawValue, withExtension: "txt")
    guard let url = file else { return 0 }
    guard let t1 = try? String.init(contentsOf: url, encoding: .utf8) else {
      return 0
    }
    let t2 = t1.components(separatedBy: " ")
    try? realm.write {
      for s in t2 {
        guard let id = Int(s) else { continue }
        if realm.object(ofType: WordRecord.self, forPrimaryKey: id) == nil {
          let newRecord = WordRecord()
          newRecord.entryId = id
          realm.add(newRecord)
          count += 1
        }
      }
    }
    return count
  }
  
  // MARK: Functiton for Test
  func printCount(isTotal: Bool) {
    let records = realm.objects(WordRecord.self)
    if isTotal {
      print(records.count)
    } else {
      for i in 0...5 {
        let count = records.filter("privateLevel = %@", i).count
        if count != 0 {
          print("level=\(i): \(count)")
        }
      }
    }
  }
  
  func deleteAll() {
    try? realm.write {
      realm.deleteAll()
    }
  }
  
  func makeWorkbenchAllToSpellLevel() -> Int {
    let words = realm.objects(WordRecord.self).filter("privateLevel != 0 AND privateLevel != 5")
    try! realm.write {
      for word in words {
        word.state = WordRecord.State.know
      }
    }
    return words.count
  }
}
