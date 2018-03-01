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
  
  let wordsTolearn: Results<WordToday>
  var presentEntry: JMEntry!
  var presentRecord: WordRecord!
  
  unowned let containerController: StudyContainerController
  let wordPageController: WordPageController
  let knowQuizController: KnowQuizController
  //let spellQuizController: SpellQuizController
  var presentController: UIViewController?
  
  init(containerView: StudyContainerController) {
    realm = bookManager.realm

    wordsTolearn = realm.objects(WordToday.self).filter("privateState != 1")
    
    self.containerController = containerView
    wordPageController = UIStoryboard.instantiateController(identifier: "WordPageController") as! WordPageController
    knowQuizController = UIStoryboard.instantiateController(identifier: "KnowQuizController") as! KnowQuizController
    //spellQuizController = UIStoryboard.instantiateController(identifier: "SpellQuizController") as! SpellQuizController
    
    wordPageController.studyManager = self
    knowQuizController.studyManager = self
    //spellQuizController.studyManager = self
    sizeChildController([wordPageController, knowQuizController])
    addChildController(wordPageController)
    addChildController(knowQuizController)
  }
  
  private func sizeChildController(_ controllers: [UIViewController]) {
    for controller in controllers {
      controller.view.frame = containerController.view.bounds
      controller.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
  }
  
  private func addChildController(_ controller: UIViewController) {
    containerController.addChildViewController(controller)
    controller.didMove(toParentViewController: containerController)
    //containerView.view.addSubview(controller.view)
  }
  
//  private func removeChildController(_ controller: UIViewController) {
//    controller.willMove(toParentViewController: nil)
//    controlelr.view
//    controller.removeFromParentViewController()
//
//  }
//
  func processNextQuiz() {
    if let nextWord = wordsTolearn.first {
      presentRecord = bookManager.getWordRecord(entryID: nextWord.entryId)
      presentEntry = dicManager.getEntry(id: presentRecord.entryId)
      // prepare next quiz
      switch presentRecord.state {
      case .wait, .master:
        assert(true)
      case .ready, .familiar:
        // prepare KnowQuiz
        knowQuizController.load(kanji: presentEntry.kanji, entryID: presentEntry.id)
        containerController.view.addSubview(knowQuizController.view)
      case .know, .spell:
        // prepare SpellQuiz
        //spellQuizController.initial(entry: entry)
        break
      }
    } else {
      // complete all task
    }
  }
  
  func showWordPage(method: WordPageController.openMethod) {
    wordPageController.load(entry: presentEntry, method: method)
    containerController.view.addSubview(wordPageController.view)
  }
  
}
