//
//  StudyContainerController.swift
//  Jword
//
//  Created by usagilynn on 2/25/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class StudyContainerController: UIViewController, Colorizable {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var homeButton: UIButton!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var completeView: UIView!
  
  var studyViewModel: StudyViewModel!

  // MARK: - View Controller
  override func viewDidLoad() {
    super.viewDidLoad()
    Theme.addObserver(controller: self)
    let homeImage = UIImage(named: "home.png")?.withRenderingMode(.alwaysTemplate)
    let searchImage = UIImage(named: "smallSearch.png")?.withRenderingMode(.alwaysTemplate)
    homeButton.imageView?.image = homeImage
    searchButton.imageView?.image = searchImage
    studyViewModel = StudyViewModel(containerController: self)
    studyViewModel.prepareWordsAndProcessNextPage()
  }
  
  func applyTheme() {
    view.backgroundColor = Theme.background
    titleLabel.textColor = Theme.text
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
