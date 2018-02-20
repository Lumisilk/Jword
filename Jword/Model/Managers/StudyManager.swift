//
//  StudyManager.swift
//  Jword
//
//  Created by usagilynn on 2/10/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import Foundation
import RealmSwift

final class StudyManager {
  
  private let realm: Realm
  
  let wordsLearnt: Results<WordToday>
  let wordsTolearn: Results<WordToday>
  
  init() {
    var config = Realm.Configuration()
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    print(documentURL)
    config.fileURL = documentURL.appendingPathComponent("WordBook.realm")
    config.objectTypes = [WordRecord.self, WordToday.self]
    config.schemaVersion = 0
    realm = try! Realm(configuration: config)
    
    wordsLearnt = realm.objects(WordToday.self).filter("learnt = 2")
    wordsTolearn = realm.objects(WordToday.self).filter("learnt != 2")
  }
  
  func getNextWord() -> WordToday? {
    return wordsTolearn.first
  }
  
}
