//
//  HomePageController.swift
//  Jword
//
//  Created by usagilynn on 2/15/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class HomePageController: UIViewController, Colorizable {

  @IBOutlet weak var todayButton: HomeButton!
  @IBOutlet weak var studyButton: HomeButton!
  @IBOutlet weak var searchButton: HomeButton!
  @IBOutlet weak var settingButton: HomeButton!
  
  private let bookManager = BookManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    todayButton.load(type: .wordToday)
    studyButton.load(type: .study)
    searchButton.load(type: .search)
    settingButton.load(type: .setting)
    Theme.addObserver(controller: self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    let count = bookManager.wordsToday.count
    todayButton.subTitle = count != 0 ? count.description : ""
    let progress = bookManager.progress
    studyButton.subTitle = progress != 0 ? "\(progress)%" : ""
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let id = segue.identifier {
      let nv = segue.destination as! UINavigationController
      let vc = nv.topViewController as! WordListConrtoller
      if id == "showWordTodayList" {
        vc.isForSearching = false
      } else if id == "showSearchList" {
        vc.isForSearching = true
      }
    }
  }
  
  func applyTheme() {
    view.backgroundColor = Theme.background
    [todayButton, searchButton, studyButton, settingButton].applyTheme()
  }

}
