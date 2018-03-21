//
//  HomePageController.swift
//  Jword
//
//  Created by usagilynn on 2/15/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit
import RealmSwift

final class HomePageController: UIViewController, Colorizable {

  @IBOutlet weak var todayButton: HomeButton!
  @IBOutlet weak var studyButton: HomeButton!
  @IBOutlet weak var searchButton: HomeButton!
  @IBOutlet weak var settingButton: HomeButton!
  
  var token: NotificationToken? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    todayButton.load(type: .wordToday)
    studyButton.load(type: .study)
    searchButton.load(type: .search)
    settingButton.load(type: .setting)
    Theme.addObserver(controller: self)
    
    token = BookManager.shared.wordsToday.observe{ [weak self] change in
      switch change {
      case .initial, .update(_,_,_,_):
        self?.todayButton.subTitle = BookManager.shared.wordsToday.count.description + " words"
        self?.studyButton.subTitle = BookManager.shared.progress.description + "%"
      case .error(let error):
        fatalError("\(error)")
      }
    }
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

  deinit {
    token?.invalidate()
  }
}
