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
  @objc dynamic var gloss: String = ""
  
  var pos: Set<SensePos> {
    var set = Set<SensePos>()
    for i in privatePos.split(separator: "@") {
      if let t = SensePos(rawValue: String(i)) {
        set.insert(t)
      }
    }
    return set
  }
  var info: Set<SenseInfo> {
    var set = Set<SenseInfo>()
    for i in privateInfo.split(separator: "@") {
      if let t = SenseInfo(rawValue: String(i)) {
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
    for i in lsource.split(separator: "@") {
      let j = i.split(separator: "^")
      if let lan = SenseSource(rawValue: String(j[0])) {
        res[lan] = String(j[1])
      }
    }
    return res
  }
  
  override static func indexedProperties() -> [String] {
    return ["gloss"]
  }
}
