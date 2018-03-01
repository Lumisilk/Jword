//
//  KnowQuizController.swift
//  Jword
//
//  Created by usagilynn on 2/22/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class KnowQuizController: UIViewController {
  
  @IBOutlet weak var labelContainer: UIView!
  @IBOutlet weak var kanjiLabel: UILabel!
  @IBOutlet weak var easyButton: UIButton!
  
  @IBOutlet weak var KnowButtonContainer: UIView!
  @IBOutlet weak var yesButton: UIButton!
  @IBOutlet weak var noButton: UIButton!
  
  let bookManager = BookManager.shared()
  weak var studyManager: StudyManager?
  var kanji: String = ""
  var entryID: Int = 0
  var isPropertyLoaded = false
  
  override func viewDidLoad() {
    initView()
    if isPropertyLoaded {
      loadPage()
    }
  }
  
  private func initView() {
    view.backgroundColor = ColorManager.background
    UIView.addRadius(views: [labelContainer, easyButton, KnowButtonContainer], radius: 13)
    //UIView.addShadows(views: [labelContainer, easyButton, KnowButtonContainer])
    easyButton.backgroundColor = ColorManager.frontBackground
    KnowButtonContainer.backgroundColor = ColorManager.frontBackground
    
    easyButton.addTarget(self, action: #selector(pressTooEasy), for: .touchUpInside)
    yesButton.addTarget(self, action: #selector(pressKnow), for: .touchUpInside)
    noButton.addTarget(self, action: #selector(pressDontKnow), for: .touchUpInside)
  }
  private func loadPage() {
    kanjiLabel.text = kanji
  }
  
  func load(kanji: String, entryID: Int) {
    self.kanji = kanji
    self.entryID = entryID
    if isViewLoaded {
      loadPage()
    }
    isPropertyLoaded = true
  }
  
  @objc private func pressTooEasy() {
    // TODO: confirm make word too easy
    bookManager.tooEasy(entryID: entryID)
    studyManager?.processNextQuiz()
  }
  @objc private func pressKnow() {
    bookManager.pass(entryID: entryID)
    studyManager?.showWordPage(method: .passed)
  }
  @objc private func pressDontKnow() {
    bookManager.addOrForget(entryID: entryID)
    studyManager?.showWordPage(method: .failed)
  }
  
}
