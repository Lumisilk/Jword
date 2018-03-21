//
//  WordBookManager.swift
//  Jword
//
//  Created by usagilynn on 2/9/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import Foundation
import RealmSwift

struct BookManager {
  
  static let shared = BookManager()
  
  let realm: Realm
  let wordsToday: Results<WordToday>
  
  private init() {
    var config = Realm.Configuration()
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    print(documentURL)
    config.fileURL = documentURL.appendingPathComponent("WordBook.realm")
    config.objectTypes = [WordRecord.self, WordToday.self]
    config.schemaVersion = 0
    realm = try! Realm(configuration: config)
    wordsToday = realm.objects(WordToday.self)
  }
  
  // MARK: Query Method
  func getWordRecord(entryID: Int) -> WordRecord? {
    return realm.object(ofType: WordRecord.self, forPrimaryKey: entryID)
  }
  var wordsTodayCount: Int {
    return wordsToday.count
  }
  var wordsTodayCountToLearn: Int {
    return wordsToday.filter(WordToday.wordTodayToLearn).count
  }
  var progress: Int {
    guard wordsToday.count != 0 else { return 0 }
    let count = wordsToday.count - wordsTodayCountToLearn
    return count * 100 / wordsToday.count
  }
  
  // MARK: Daily Check
  func dailyCheck() {
    let lastUpdate = UserDataManager.lastUpdateDate ?? Date().addingTimeInterval(TimeInterval(-86400))
    if !Calendar.current.isDateInToday(lastUpdate) {
      supplyWorkbench()
      refreshWordToday()
      UserDataManager.lastUpdateDate = Date()
    }
  }
  
  func supplyWorkbench() {
    let workbenchCount = UserDataManager.countOfWorkbench
    let currentCount = realm.objects(WordRecord.self).filter(WordRecord.wordRecordsInWorkbench).count
    if currentCount < workbenchCount {
      let need = workbenchCount - currentCount
      var wordReadyToLearn = Array(realm.objects(WordRecord.self).filter(WordRecord.wordRecordsWaiting))
      if need < wordReadyToLearn.count {
        wordReadyToLearn = wordReadyToLearn.randomPick(n: need)
      }
      try! realm.write {
        for word in wordReadyToLearn {
          word.level = .ready
        }
      }
    }
  }
  
  func refreshWordToday() {
    try! realm.write {
      let amountToLearnEveryday = UserDataManager.countToLearnEveryday
      var workbench = Array(realm.objects(WordRecord.self).filter(WordRecord.wordRecordsInWorkbench))
      realm.delete(realm.objects(WordToday.self))
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
  private func privateForget(entryID: Int) {
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
  
  func addOrForget(entryID: Int) {
    try! realm.write {
      privateForget(entryID: entryID)
    }
  }
  
  // MARK: Add Vocabulary Book Method
  enum VocabularyBook: String {
    case N1
  }
  func addVocabularyBook(_ book: VocabularyBook, refreshOldWords: Bool) -> Int {
    var count = 0
    let file = Bundle.main.url(forResource: book.rawValue, withExtension: "txt")
    guard let url = file else { return 0 }
    guard let t1 = try? String.init(contentsOf: url, encoding: .utf8) else {
      return 0
    }
    let IDs: [Int] = t1.split(separator: " ").map{Int($0)!}
    try! realm.write {
      if refreshOldWords {
        count = IDs.count
        IDs.forEach(privateForget(entryID:))
      } else {
        for id in IDs where realm.object(ofType: WordRecord.self, forPrimaryKey: id) == nil {
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
    try! realm.write {
      realm.deleteAll()
    }
  }
  
  func makeWorkbenchAllToSpellLevel() -> Int {
    let words = realm.objects(WordRecord.self).filter(WordRecord.wordRecordsInWorkbench)
    try! realm.write {
      words.forEach{$0.level = .know}
      wordsToday.forEach {$0.state = .forgotten}
    }
    return words.count
  }
}
