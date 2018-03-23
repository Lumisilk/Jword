//
//  KnowQuizController.swift
//  Jword
//
//  Created by usagilynn on 2/22/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class KnowQuizController: UIViewController, Colorizable {
  
  private enum State {
    case start
    case showedSentence
  }
  
  @IBOutlet weak var labelContainer: UIView!
  @IBOutlet weak var kanjiLabel: UILabel!
  
  @IBOutlet weak var sentenceContainer: UIView!
  @IBOutlet weak var sentenceLabel: UILabel!
  
  @IBOutlet weak var yesButton: JWButton!
  @IBOutlet weak var noButton: JWButton!
  
  weak var studyViewModel: StudyViewModel!
  private var entry: JMEntry?
  private var state: State = .start
  
  // MARK: - ViewController
  override func viewDidLoad() {
    initView()
    Theme.addObserver(controller: self)
  }
  
  private func initView() {
    [labelContainer, sentenceContainer].addRadius()
    sentenceContainer.isHidden = true
    yesButton.initial(title: "Know", after: "", isNormal: true)
    noButton.initial(title: "Don't know'", after: "", isNormal: false)
  }
  func applyTheme() {
    view.backgroundColor = Theme.background
    labelContainer.backgroundColor = Theme.foreground
    sentenceContainer.backgroundColor = Theme.foreground
    kanjiLabel.textColor = Theme.text
    sentenceLabel.textColor = Theme.text
    yesButton.applyTheme()
    noButton.applyTheme()
  }
  
  private func updateView() {
    kanjiLabel.text = entry?.kanji
    if let example = entry?.pickOneExample() {
      sentenceLabel.text = example.japanese
    } else {
      state = .showedSentence
    }
  }
  
  // MARK: - Data Interface
  func load(entry: JMEntry) {
    self.entry = entry
    state = .start
    sentenceContainer.isHidden = true
    updateView()
  }

  @IBAction func pressKnow(_ sender: Any) {
    studyViewModel.pass()
    studyViewModel.showWordPage(method: .passed)
  }
  @IBAction func pressNotKnow(_ sender: Any) {
    switch state {
    case .start:
      sentenceContainer.isHidden = false
      state = .showedSentence
    case .showedSentence:
      studyViewModel.forget()
      studyViewModel.showWordPage(method: .failed)
    }
  }
}
