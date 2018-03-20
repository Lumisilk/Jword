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
    for i in privateInfo.split(separator: "@") {
      if let t = EntryInfo(rawValue: String(i)) {
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
  
  func firstGlossToLabelText() -> String {
    let first = senses.first!
    return first.gloss.replacingOccurrences(of: "@", with: "\n")
  }
  
  func pickOneExample() -> TNKExample? {
    guard !examples.isEmpty else { return nil }
    let idx = Int.random(examples.count)
    return examples[idx]
  }
}
