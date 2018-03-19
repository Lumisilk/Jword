//
//  StudyContainerController.swift
//  Jword
//
//  Created by usagilynn on 2/25/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class StudyContainerController: UIViewController, Colorizable {
  
  
  @IBOutlet weak var homeButton: UIButton!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var completeView: UIView!
  
  var studyViewModel: StudyViewModel!

  // MARK: - View Controller
  override func viewDidLoad() {
    super.viewDidLoad()
    studyViewModel = StudyViewModel(containerController: self)
    studyViewModel.prepareWordsAndProcessNextPage()
    Theme.addObserver(controller: self)
  }
  
  func applyTheme() {
    view.backgroundColor = Theme.background
    homeButton.tintColor = Theme.tint
    searchButton.tintColor = Theme.tint
  }
  
  func addChildControllers(_ contents: [UIViewController]) {
    for content in contents {
      addChildViewController(content)
      content.view.frame = containerView.bounds
      containerView.addSubview(content.view)
      content.didMove(toParentViewController: self)
    }
  }

  // MARK: - Action
  @IBAction func returnToHome(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }

  

}

