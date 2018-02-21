//
//  SearchPageController.swift
//  Jword
//
//  Created by usagilynn on 2/10/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class SearchPageController: UITableViewController {

  let searchController = UISearchController(searchResultsController: nil)
  
  let dictionary = DictManager()
  var searchResults = [JMEntry]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "漢字/ローマ字/English"
    searchController.hidesNavigationBarDuringPresentation = false
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    //definesPresentationContext = true

    
  }
  
  // MARK: - TableView
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchPageCell", for: indexPath)
    let entry = searchResults[indexPath.row]
    cell.textLabel?.text = entry.kanji
    cell.detailTextLabel?.text = entry.reading
    return cell
  }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let entry = searchResults[indexPath.row]
    performSegue(withIdentifier: "showWordPage", sender: entry)
  }
  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if refreshControl!.isRefreshing {
      dismiss(animated: true, completion: nil)
    }
  }

  // MARK: - View Function
  @IBAction func dismiss(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showWordPage" {
      let entry = sender as! JMEntry
      let controller = segue.destination as! WordPageController
      controller.entry = entry
      controller.loadWord(entry: entry, record: nil)
    }
  }
}

// MARK: - UISearchResultsUpdating Delegate
extension SearchPageController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard !searchController.searchBar.text!.isEmpty else {
      return
    }
    searchResults = dictionary.search(kanji: searchController.searchBar.text!)
    tableView.reloadData()
  }
}
