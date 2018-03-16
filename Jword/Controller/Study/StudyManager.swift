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
  
  private let dictManager = DictManager.shared
  private let bookManager = BookManager.shared
  
  private var wordsTolearn = [WordToday]()
  private var presentEntry = JMEntry()
  private var presentRecord = WordRecord()
  private var presentWordToday = WordToday()
  
  private unowned let containerController: StudyContainerController
  private let wordPageController: WordPageController
  private let knowQuizController: KnowQuizController
  private let spellQuizController: SpellQuizController
  
  init(containerView: StudyContainerController) {
    self.containerController = containerView
    wordPageController = UIStoryboard.instantiateController(name: "Main", id: "WordPageController") as! WordPageController
    knowQuizController = UIStoryboard.instantiateController(name: "Study", id: "KnowQuizController") as! KnowQuizController
    spellQuizController = UIStoryboard.instantiateController(name: "Study", id: "SpellQuizController") as! SpellQuizController

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

  // MARK: - Process
  func prepareWordsAndProcessNextPage() {
    wordsTolearn = Array(bookManager.wordsToday.filter(WordToday.wordTodayToLearn)).shuffled()
    if wordsTolearn.isEmpty {
      containerController.view.bringSubview(toFront: containerController.completeView)
    } else {
      processNextQuiz()
    }
  }
  
  func processNextQuiz() {
    if let nextWord = wordsTolearn.last {
      wordsTolearn.removeLast()
      presentWordToday = nextWord
      presentRecord = bookManager.getWordRecord(entryID: nextWord.entryId)!
      presentEntry = dictManager.getEntry(id: nextWord.entryId)
      // prepare next quiz
      switch presentRecord.state {
      case .ready, .familiar:
        knowQuizController.load(entry: presentEntry)
        containerController.view.addSubview(knowQuizController.view)
      case .know, .spell:
        spellQuizController.load(entry: presentEntry)
        containerController.view.addSubview(spellQuizController.view)
      default:
        assert(true)
      }
    } else {
      prepareWordsAndProcessNextPage()
    }
  }
  
  func showWordPage(method: WordPageController.openMethod) {
    wordPageController.loadData(entry: presentEntry, method: method, record: presentRecord)
    containerController.view.addSubview(wordPageController.view)
  }
  
  // MARK: - Word Operation 
  func forget() {
    try! bookManager.realm.write {
      presentWordToday.forget()
      presentRecord.forget()
    }
  }
  func pass() {
    try! bookManager.realm.write {
      presentWordToday.pass()
      presentRecord.pass()
    }
  }
  
}
