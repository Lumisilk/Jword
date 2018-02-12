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
    realm = UserDataManager.shared.realm
    wordsLearnt = realm.objects(WordToday.self).filter("learnt = 2")
    wordsTolearn = realm.objects(WordToday.self).filter("learnt != 2")
  }
  
  func getNextWord() -> WordToday? {
    return wordsTolearn.first
  }
  
}
