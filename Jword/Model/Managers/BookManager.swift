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
    realm = UserDataManager.shared.realm
  }
  
  func get(WordRecord id: Int) -> WordRecord? {
    return realm.object(ofType: WordRecord.self, forPrimaryKey: id)
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
  
  func refreshWordToday() {
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
}
