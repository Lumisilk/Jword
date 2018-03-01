//
//  AddNewRecords.swift
//  BookManagerTests
//
//  Created by usagilynn on 2/28/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import XCTest
@testable import Jword

class AddNewRecords: XCTestCase {
  
  var dictManager = DictManager.shared()
  var bookManager = BookManager.shared()
  let wordsToAdd = [
    "反る", "練る", "煙る", "募る", "図る", "勝る", "操る", "誤る", "群がる", "連なる",
    "交わる", "老いる", "強いる", "率いる", "恥じる", "重んじる", "帯びる", "省みる", "試みる", "経る",
    "絶える", "映える", "構える", "仕える", "生ける", "化ける", "授ける", "設ける", "挙げる", "告げる",
    "和らげる", "果てる", "定める", "乱れる", "敗れる", "訪れる", "値する", "襲う", "慕う", "潤う",
    "漂う", "繕う", "賄う", "裁く", "嘆く", "懐く", "欺く", "赴く", "貫く", "継ぐ"
  ]
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testExample() {
    for word in wordsToAdd {
      let res = dictManager.search(kanji: word)
      if let e = res.first {
        bookManager.addOrForget(entryID: e.id)
      }
    }
    bookManager.printAmount()
  }
  
  func testPerformanceExample() {
    self.measure {
      
    }
  }
    
}
