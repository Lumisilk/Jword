//
//  KnowQuizController.swift
//  Jword
//
//  Created by usagilynn on 2/22/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class KnowQuizController: UIViewController {
  
  private enum State {
    case start
    case showedSentence
  }
  
  @IBOutlet weak var labelContainer: UIView!
  @IBOutlet weak var kanjiLabel: UILabel!
  
  @IBOutlet weak var sentenceContainer: UIView!
  @IBOutlet weak var sentenceLabel: UILabel!
  
  @IBOutlet weak var KnowButtonContainer: UIView!
  @IBOutlet weak var yesButton: UIButton!
  @IBOutlet weak var noButton: UIButton!
  
  weak var studyManager: StudyManager?
  private var entry: JMEntry?
  private var state: State = .start
  
  override func viewDidLoad() {
    initView()
    applyTheme()
    if entry != nil {
      loadPage()
    }
  }
  
  private func initView() {
    UIView.addRadius(views: [labelContainer, sentenceContainer, KnowButtonContainer], radius: 16)
    sentenceContainer.isHidden = true
    //UIView.addShadows(views: [labelContainer, sentenceContainer, KnowButtonContainer])
    let inset = UIEdgeInsetsMake(0, 20, 0, 0)
    yesButton.titleEdgeInsets = inset
    noButton.titleEdgeInsets = inset
  }
  private func applyTheme() {
    view.backgroundColor = ColorManager.background
    labelContainer.backgroundColor = ColorManager.frontBackground
    sentenceContainer.backgroundColor = ColorManager.frontBackground
    KnowButtonContainer.backgroundColor = ColorManager.frontBackground
  }
  
  private func loadPage() {
    kanjiLabel.text = entry?.kanji
    if let example = entry?.pickOneExample() {
      sentenceLabel.text = example.japanese
    } else {
      state = .showedSentence
    }
  }
  
  func load(entry: JMEntry) {
    self.entry = entry
    state = .start
    sentenceContainer.isHidden = true
    if isViewLoaded {
      loadPage()
    }
  }

  @IBAction func pressKnow(_ sender: Any) {
    studyManager?.pass()
    studyManager?.showWordPage(method: .passed)
  }
  @IBAction func pressNotKnow(_ sender: Any) {
    switch state {
    case .start:
      sentenceContainer.isHidden = false
      state = .showedSentence
    case .showedSentence:
      studyManager?.forget()
      studyManager?.showWordPage(method: .failed)
    }
  }
}
