//
//  DailyCheck.swift
//  BookManagerTests
//
//  Created by usagilynn on 3/8/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import XCTest
@testable import Jword

class DailyCheck: XCTestCase {
    
  let bookManager = BookManager.shared
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    
    super.tearDown()
  }
  
  func testExample() {
    bookManager.printCount(isTotal: false)
    let dateString = "2018-01-01"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    guard let lastUpdateDate = dateFormatter.date(from: dateString) else {
      fatalError("ERROR: Date conversion failed due to mismatched format.")
    }
    UserDataManager.lastUpdateDate = lastUpdateDate
    bookManager.dailyCheck()
    bookManager.printCount(isTotal: false)
  }
  
  func testPerformanceExample() {
    self.measure {
    }
  }
}
