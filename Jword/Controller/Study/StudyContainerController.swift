//
//  StudyContainerController.swift
//  Jword
//
//  Created by usagilynn on 2/25/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class StudyContainerController: UIViewController {
  
  @IBOutlet weak var completeView: UIView!
  
  var studyManager: StudyManager!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    studyManager = StudyManager(containerView: self)
    studyManager.prepareWordsAndProcessNextPage()
  }

  @IBAction func returnToHome(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }

}

