//
//  SearchPageController.swift
//  Jword
//
//  Created by usagilynn on 2/10/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class WordListConrtoller: UITableViewController {
  
  //let searchController = UISearchController(searchResultsController: nil)
  
  let dictManager = DictManager.shared
  let bookManager = BookManager.shared
  var wordList = [JMEntry]()
  
  /// A boolean value indicates this page is searching page or wordToday list.
  var isForSearching = true
  
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
      let wordToday = bookManager.getWordToday()
      wordList = dictManager.getEntries(of: wordToday)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if isForSearching {
      DispatchQueue.main.async { [unowned self] in
        self.navigationItem.searchController?.searchBar.becomeFirstResponder()
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
    performSegue(withIdentifier: "showWordPage", sender: entry)
  }
  
  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    // TODO: send dismiss
  }

  // MARK: - View Function
  @IBAction func dismiss(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    dismiss(animated: true, completion: nil)
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showWordPage" {
      let entry = sender as! JMEntry
      let controller = segue.destination as! WordPageController
      if isForSearching {
        controller.load(entry: entry, method: .search)
      } else {
        controller.load(entry: entry, method: .wordList)
      }
    }
  }
}

// MARK: - UISearchResultsUpdating Delegate
extension WordListConrtoller: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard !searchController.searchBar.text!.isEmpty else { return }
    wordList = dictManager.search(kanji: searchController.searchBar.text!)
    tableView.reloadData()
  }
}
