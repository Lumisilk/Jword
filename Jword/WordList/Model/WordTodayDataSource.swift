//
//  wordTodayDataSource.swift
//  Jword
//
//  Created by usagilynn on 3/21/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit
import RealmSwift

final class WordTodayDataSource: NSObject, WordListDataSource {
  
  private var dictManager = DictManager.shared
  private var bookManager = BookManager.shared
  private var wordsToday: Results<WordToday>
  
  var token: NotificationToken? = nil
  
  init(tableView: UITableView) {
    wordsToday = bookManager.wordsToday
    super.init()
    token = wordsToday.observe { [weak self] change in
      guard let this = self else { return }
      switch change {
      case .initial:
        break
      case .update(_, let deletions, let insertions, _):
        tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                             with: .automatic)
        tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                             with: .automatic)
      case .error(let error):
        fatalError("\(error)")
      }
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return wordsToday.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchListCell")!
    let entry = self.entry(at: indexPath.row)
    cell.configure(entry: entry)
    return cell
  }
  
  func entry(at row: Int) -> JMEntry {
    let word = wordsToday[row]
    let entry = dictManager.getEntry(id: word.entryId)
    return entry
  }
  
  deinit {
    token?.invalidate()
  }
}
