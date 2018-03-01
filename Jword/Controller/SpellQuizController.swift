//
//  SpellQuizController.swift
//  Jword
//
//  Created by usagilynn on 2/22/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class SpellQuizController: UIViewController {
  
  let bookManager = BookManager.shared()
  weak var studyManager: StudyManager?
  var entry: JMEntry!
  var sentence: TNKExample?
  
  override func viewDidLoad() {
    initView()
    loadQuiz()
  }
  
  private func initView() {
  
  }
  
  func initial(entry: JMEntry) {
    self.entry = entry
    if entry.examples.isEmpty {
      sentence = nil
    } else {
      let idx = arc4random_uniform(UInt32(entry.examples.count))
      sentence = entry.examples[Int(idx)]
    }
  }
  
  private func loadQuiz() {
    
  }
  
  func reloadQuiz(entry: JMEntry) {
    initial(entry: entry)
    loadQuiz()
  }
  
}
