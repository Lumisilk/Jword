//
//  StudyManager.swift
//  Jword
//
//  Created by usagilynn on 2/10/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit
import RealmSwift

final class StudyManager {
  
  private let dicManager = DictManager.shared()
  private let bookManager = BookManager.shared()
  private let realm: Realm
  
  var wordsTolearn: [WordToday]
  var presentEntry = JMEntry()
  var presentRecord = WordRecord()
  var presentWordToday = WordToday()
  
  unowned let containerController: StudyContainerController
  let wordPageController: WordPageController
  let knowQuizController: KnowQuizController
  let spellQuizController: SpellQuizController
  
  init(containerView: StudyContainerController) {
    realm = bookManager.realm

    wordsTolearn = Array(realm.objects(WordToday.self).filter("privateState != 1")).shuffled()

    self.containerController = containerView
    wordPageController = UIStoryboard.instantiateController(identifier: "WordPageController") as! WordPageController
    knowQuizController = UIStoryboard.instantiateController(identifier: "KnowQuizController") as! KnowQuizController
    spellQuizController = UIStoryboard.instantiateController(identifier: "SpellQuizController") as! SpellQuizController
    
    wordPageController.studyManager = self
    knowQuizController.studyManager = self
    spellQuizController.studyManager = self
    addChildController([wordPageController, knowQuizController, spellQuizController])
  }
  
  // MARK: Child Controller Method
  private func addChildController(_ controllers: [UIViewController]) {
    for controller in controllers {
      containerController.addChildViewController(controller)
      controller.didMove(toParentViewController: containerController)
      controller.view.frame = containerController.view.bounds
      controller.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
  }
  
  private func removeChildController(_ controller: UIViewController) {
    controller.willMove(toParentViewController: nil)
    controller.view.removeFromSuperview()
    controller.removeFromParentViewController()
  }

  // MARK: Process Method
  func processNextQuiz() {

    if let nextWord = wordsTolearn.last {
      wordsTolearn.removeLast()
      presentWordToday = nextWord
      presentRecord = bookManager.getWordRecord(entryID: nextWord.entryId)!
      presentEntry = dicManager.getEntry(id: nextWord.entryId)
      // prepare next quiz
      switch presentRecord.state {
      case .wait, .master:
        assert(true)
      case .ready, .familiar:
        // prepare KnowQuiz
//        knowQuizController.load(entry: presentEntry)
//        containerController.view.addSubview(knowQuizController.view)
        fallthrough
      case .know, .spell:
        spellQuizController.load(entry: presentEntry)
        containerController.view.addSubview(spellQuizController.view)
      }
    } else {
      wordsTolearn = Array(realm.objects(WordToday.self).filter("privateState != 1")).shuffled()
      if wordsTolearn.isEmpty {
        // TODO: complete all word today
      } else {
        processNextQuiz()
      }
    }
  }
  
  func showWordPage(method: WordPageController.openMethod) {
    wordPageController.load(entry: presentEntry, method: method, record: presentRecord)
    containerController.view.addSubview(wordPageController.view)
  }
  
  // MARK: Word Operation Method
  func forget() {
    try? realm.write {
      presentWordToday.forget()
      presentRecord.forget()
    }
  }
  func pass() {
    try? realm.write {
      presentWordToday.pass()
      presentRecord.pass()
    }
  }
  
}
