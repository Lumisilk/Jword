//
//  StudyContainerController.swift
//  Jword
//
//  Created by usagilynn on 2/25/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class StudyContainerController: UIViewController {
  
  var studyManager: StudyManager!
  
  @IBOutlet weak var homeButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    studyManager = StudyManager(containerView: self)
    initView()
    studyManager.processNextQuiz()
  }
  
  @IBAction func returnToHome(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  private func initView() {
    
  }
}
