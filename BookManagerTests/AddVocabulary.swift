//
//  AddN1Vocabulary.swift
//  BookManagerTests
//
//  Created by usagilynn on 3/8/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import XCTest
@testable import Jword

class AddVocabulary: XCTestCase {
  
  let bookManager = BookManager.shared
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testExample() {
    bookManager.deleteAll()
    let count = bookManager.addVocabularyBook(.N1, refreshOldWords: true)
    print("Count of words added is \(count)")
  }
  
  func testPerformanceExample() {
    self.measure {
    }
  }
}
