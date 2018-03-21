//
//  SearchDataSource.swift
//  Jword
//
//  Created by usagilynn on 3/21/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

protocol WordListDataSource: UITableViewDataSource {
  func entry(at row: Int) -> JMEntry
}

final class SearchDataSource: NSObject, WordListDataSource {
  
  private var searchResults: [JMEntry] = []
  private var dictManager = DictManager.shared
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchListCell")!
    let entry = searchResults[indexPath.row]
    cell.configure(entry: entry)
    return cell
  }
  
  func entry(at row: Int) -> JMEntry {
    return searchResults[row]
  }
  
  func updateResult(input: String) {
    if input.isEmpty {
      let history = UserDataManager.searchHistory
      searchResults = dictManager.getEntries(IDs: history)
    } else {
      searchResults = dictManager.search(kanji: input)
    }
  }
}
