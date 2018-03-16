//
//  TNKExample.swift
//  Jword
//
//  Created by usagilynn on 2/8/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import Foundation
import RealmSwift

final class TNKExample: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var japanese: String = ""
  @objc dynamic var english: String = ""
  let entries = LinkingObjects(fromType: JMEntry.self, property: "examples")
  let words = List<String>()
  let deformations = List<String>()
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
