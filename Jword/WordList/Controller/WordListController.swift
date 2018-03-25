//
//  SearchPageController.swift
//  Jword
//
//  Created by usagilynn on 2/10/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class WordListConrtoller: UITableViewController, Colorizable {
  
  var dataSource: WordListDataSource?
  
  /// A boolean value indicates this page is a searching page or a wordToday list.
  var isForSearching = true
  
  // MARK: - ViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
    Theme.addObserver(controller: self)
    
    if isForSearching {
      dataSource = SearchDataSource()
      navigationItem.title = "Search"
      let searchController = UISearchController(searchResultsController: nil)
      searchController.searchBar.placeholder = "漢字/ローマ字/English"
      searchController.searchResultsUpdater = self
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.hidesNavigationBarDuringPresentation = false
      navigationItem.searchController = searchController
      navigationItem.hidesSearchBarWhenScrolling = false
    } else {
      dataSource = WordTodayDataSource(tableView: tableView)
      navigationItem.title = "Words Today"
    }
    
    tableView.dataSource = dataSource
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
    tableView.backgroundColor = Theme.background
    navigationController?.navigationBar.tintColor = Theme.tint
    navigationController?.navigationBar.barStyle = Theme.barStyle
    navigationItem.searchController?.searchBar.tintColor = Theme.tint
    
    tableView.backgroundColor = Theme.foreground
    for cell in tableView.visibleCells {
      cell.textLabel?.textColor = Theme.text
      cell.detailTextLabel?.textColor = Theme.subText
    }
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
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.navigationItem.searchController?.searchBar.resignFirstResponder()
    let entry = dataSource?.fetch(at: indexPath.row)
    performSegue(withIdentifier: "showWordPage", sender: entry)
  }
  
}

// MARK: - UISearchResultsUpdating Delegate
extension WordListConrtoller: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    if isForSearching {
      (dataSource as! SearchDataSource).updateResult(input: searchController.searchBar.text!)
    }
    tableView.reloadData()
  }
}
