//
//  makeAllToSpell.swift
//  BookManagerTests
//
//  Created by usagilynn on 3/9/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import XCTest
@testable import Jword

class makeAllToSpell: XCTestCase {
  
  let bookManager = BookManager.shared
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testExample() {
    print(bookManager.makeWorkbenchAllToSpellLevel())
  }
  
  func testPerformanceExample() {
    self.measure {
      
    }
  }
}
