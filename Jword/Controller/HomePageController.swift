//
//  HomePageController.swift
//  Jword
//
//  Created by usagilynn on 2/15/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class HomePageController: UIViewController {

  @IBOutlet weak var row1Stack: UIStackView!
  @IBOutlet weak var row2Stack: UIStackView!
  
  @IBOutlet weak var todayButton: HomeButton!
  @IBOutlet weak var studyButton: HomeButton!
  @IBOutlet weak var searchButton: HomeButton!
  @IBOutlet weak var settingButton: HomeButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = ColorManager.background
    
    todayButton.load(type: .wordToday)
    studyButton.load(type: .study)
    searchButton.load(type: .search)
    settingButton.load(type: .setting)
    print(todayButton.bounds)
    todayButton.loadGradient()
  }

//  override func viewDidAppear(_ animated: Bool) {
//    super.viewDidAppear(animated)
//    todayButton.loadGradient()
//    print(todayButton.bounds)
//    print("viewWillLayoutSubviews")
//  }
}
