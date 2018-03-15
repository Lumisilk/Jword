//
//  SearchPageController.swift
//  Jword
//
//  Created by usagilynn on 2/10/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class WordListConrtoller: UITableViewController, Colorizable {
  
  let dictManager = DictManager.shared
  let bookManager = BookManager.shared
  var wordList = [JMEntry]()
  /// A boolean value indicates this page is a searching page or a wordToday list.
  var isForSearching = true
  
  // MARK: - ViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
    if isForSearching {
      navigationItem.title = "Search"
      let searchController = UISearchController(searchResultsController: nil)
      searchController.searchBar.placeholder = "漢字/ローマ字/English"
      searchController.searchResultsUpdater = self
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.hidesNavigationBarDuringPresentation = false
      navigationItem.searchController = searchController
      navigationItem.hidesSearchBarWhenScrolling = false
    } else {
      navigationItem.title = "Words Today"
      let wordToday = Array(bookManager.wordsToday)
      let IDs: [Int] = wordToday.map{$0.entryId}
      wordList = dictManager.getEntries(IDs: IDs)
    }
    Theme.addObserver(view: self)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if isForSearching {
      DispatchQueue.main.async { [unowned self] in
        self.navigationItem.searchController?.searchBar.becomeFirstResponder()
      }
    }
  }
  
  func applyTheme() {
    tableView.backgroundColor = Theme.foreground
  }
  
  @IBAction func dismiss(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    dismiss(animated: true, completion: nil)
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showWordPage" {
      let entry = sender as! JMEntry
      let controller = segue.destination as! WordPageController
      if isForSearching {
        controller.loadData(entry: entry, method: .search)
      } else {
        controller.loadData(entry: entry, method: .wordList)
      }
    }
  }

  // MARK: - TableView
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return wordList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchPageCell", for: indexPath)
    let entry = wordList[indexPath.row]
    cell.textLabel?.text = entry.kanji
    cell.detailTextLabel?.text = entry.reading
    return cell
  }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.navigationItem.searchController?.searchBar.resignFirstResponder()
    let entry = wordList[indexPath.row]
    if isForSearching { UserDataManager.addSearchHistory(entryID: entry.id) }
    performSegue(withIdentifier: "showWordPage", sender: entry)
  }
  
}

// MARK: - UISearchResultsUpdating Delegate
extension WordListConrtoller: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    if searchController.searchBar.text!.isEmpty {
      let history = UserDataManager.searchHistory
      wordList = dictManager.getEntries(IDs: history)
    } else {
      wordList = dictManager.search(kanji: searchController.searchBar.text!)
    }
    tableView.reloadData()
  }
}
