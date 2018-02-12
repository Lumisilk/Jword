//
//  JMSense.swift
//  Jword
//
//  Created by usagilynn on 2/8/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import Foundation
import RealmSwift

final class JMSense: Object {

  @objc dynamic private var privatePos: String = ""
  @objc dynamic private var privateInfo: String = ""
  @objc dynamic private var xref: String = ""
  @objc dynamic private var ant: String = ""
  @objc dynamic private var lsource: String = ""
  @objc dynamic var ExInfo: String = ""
  @objc dynamic private var gloss: String = ""
  
  var pos: Set<SensePos> {
    var set = Set<SensePos>()
    for i in privatePos.components(separatedBy: "@") {
      if let t = SensePos(rawValue: i) {
        set.insert(t)
      }
    }
    return set
  }
  var info: Set<SenseInfo> {
    var set = Set<SenseInfo>()
    for i in privateInfo.components(separatedBy: "@") {
      if let t = SenseInfo(rawValue: i) {
        set.insert(t)
      }
    }
    return set
  }
  var refer: [String] {
    return xref.components(separatedBy: "@")
  }
  var antonym: [String] {
    return ant.components(separatedBy: "@")
  }
  var source: [SenseSource: String] {
    var res: [SenseSource: String] = [:]
    for i in lsource.components(separatedBy: "@") {
      let j = i.components(separatedBy: "^")
      if let lan = SenseSource(rawValue: j[0]) {
        res[lan] = j[1]
      }
    }
    return res
  }
  var senses: [String] {
    return gloss.components(separatedBy: "@")
  }
  
  override static func indexedProperties() -> [String] {
    return ["gloss"]
  }
}
