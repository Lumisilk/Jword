//
//  StudyViewModel.swift
//  Jword
//
//  Created by usagilynn on 3/17/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class StudyCoordinator {
  
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
  
  init(containerController: StudyContainerController) {
    self.containerController = containerController
    
    wordPageController = UIStoryboard.instantiateController(name: "Main", id: "WordPageController") as! WordPageController
    knowQuizController = UIStoryboard.instantiateController(name: "Study", id: "KnowQuizController") as! KnowQuizController
    spellQuizController = UIStoryboard.instantiateController(name: "Study", id: "SpellQuizController") as! SpellQuizController
    
    wordPageController.studyViewModel = self
    knowQuizController.studyCoordinator = self
    spellQuizController.studyViewModel = self
    
    containerController.addChildControllers([wordPageController, knowQuizController, spellQuizController])
  }
  
  // MARK: - Process
  func prepareWordsAndProcessNextPage() {
    let words = bookManager.wordsToday.filter(WordToday.wordTodayToLearn)
    if words.isEmpty {
      //containerController.containerView.bringSubview(toFront: containerController.completeView)
      print("Complete all")
    } else {
      wordsTolearn = Array(words).shuffled()
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
      switch presentRecord.level {
      case .ready, .familiar:
        knowQuizController.load(entry: presentEntry)
        containerController.containerView.bringSubview(toFront: knowQuizController.view)
      case .know, .spell:
        spellQuizController.load(entry: presentEntry)
        containerController.containerView.bringSubview(toFront: spellQuizController.view)
        spellQuizController.inputTextField.becomeFirstResponder()
      default:
        assert(true)
      }
    } else {
      prepareWordsAndProcessNextPage()
    }
  }
  
  func showWordPage(method: WordPageController.openMethod) {
    wordPageController.loadData(entry: presentEntry, method: method, record: presentRecord)
    containerController.containerView.bringSubview(toFront: wordPageController.view)
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
