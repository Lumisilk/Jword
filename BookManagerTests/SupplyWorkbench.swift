//
//  BookManagerTests.swift
//  BookManagerTests
//
//  Created by usagilynn on 2/28/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import XCTest
@testable import Jword

class SupplyWorkbench: XCTestCase {
  
  let bookManager = BookManager.shared()
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {

    super.tearDown()
  }
  
  func testExample() {
    UserDataManager.countToLearnEveryday = 10
    bookManager.supplyWorkbench()
    bookManager.printAmount()
  }
  
  func testPerformanceExample() {
    self.measure {
      
    }
  }
}
