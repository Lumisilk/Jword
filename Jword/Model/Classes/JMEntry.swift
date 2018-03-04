//
//  JMEntry.swift
//  Jword
//
//  Created by usagilynn on 2/8/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import Foundation
import RealmSwift

final class JMEntry: Object {
  
  @objc dynamic var id: Int = 0
  @objc dynamic var groupId: Int = 0
  @objc dynamic var kanji: String = ""
  @objc dynamic var reading: String = ""
  @objc dynamic var priority: Int = 50
  @objc dynamic private var privateInfo = ""
  let senses = List<JMSense>()
  let examples = List<TNKExample>()

  var info: Set<EntryInfo> {
    var set = Set<EntryInfo>()
    for i in privateInfo.components(separatedBy: "@") {
      if let t = EntryInfo(rawValue: i) {
        set.insert(t)
      }
    }
    return set
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
  override static func indexedProperties() -> [String] {
    return ["groupId", "kanji", "reading"]
  }
  
  func pickOneExample() -> TNKExample? {
    guard !examples.isEmpty else {
      return nil
    }
    let idx = Int(arc4random_uniform(UInt32(examples.count)))
    return examples[idx]
  }
}
