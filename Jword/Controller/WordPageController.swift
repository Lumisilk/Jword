//
//  WordPageController.swift
//  Jword
//
//  Created by usagilynn on 2/10/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

fileprivate let margin: CGFloat = 20

final class WordPageController: UIViewController, Colorizable {
  
  enum openMethod {
    case wordList
    case search
    case failed
    case passed
  }
  
  // MARK: - View Property
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var entryView: EntryView!
  @IBOutlet weak var exampleView: ExampleView!
  //@IBOutlet weak var noteView: NoteView!
  
  @IBOutlet weak var buttonStack: UIStackView!
  private let forgetButton = ShrinkButton()
  private let continueButton = ShrinkButton()
  
  @IBOutlet weak var buttonStackRightCons: NSLayoutConstraint!
  @IBOutlet weak var buttonStackLeftCons: NSLayoutConstraint!
  
  // MARK: - Data Property
  let bookManager = BookManager.shared
  weak var studyViewModel: StudyViewModel?
  var entry: JMEntry!
  var record: WordRecord?
  var method: openMethod = .wordList
  var isDataLoaded = false
  var isForgotten = false
  
  // MARK: - ViewController
  override func viewDidLoad() {
    initView()
    if isDataLoaded {
      updateViewFromEntry()
      //updateViewFromRecord()
      reloadContentSize()
    }
    Theme.addObserver(controller: self)
  }
  
  private func initView() {
    changeButtonStackLength(isShort: true)
    //UIView.addShadows(views: [forgetButton, continueButton])
    [forgetButton, continueButton].addRadius(18)
    forgetButton.addTarget(self, action: #selector(addOrForget) , for: .touchUpInside)
    continueButton.setTitle("Continue", for: .normal)
    continueButton.addTarget(self, action: #selector(processNext), for: .touchUpInside)
    buttonStack.addArrangedSubview(forgetButton)
    buttonStack.addArrangedSubview(continueButton)
    view.bringSubview(toFront: buttonStack)
  }
  
  func applyTheme() {
    entryView.applyTheme()
    exampleView.applyTheme()
    view.backgroundColor = Theme.background
    forgetButton.setTitleColor(Theme.background, for: .normal)
    forgetButton.backgroundColor = isForgotten ? Theme.foreground : Theme.tint
    continueButton.backgroundColor = Theme.tint
  }
  
  private func reloadContentSize() {
    guard method != .wordList else { return }
    view.layoutIfNeeded()
    var size = stackView.frame.size
    size.height += 14 + margin * 2 + buttonStack.frame.height
    scrollView.contentSize = size
    scrollView.setContentOffset(CGPoint.zero, animated: false)
    
    entryView.layer.shadowPath = UIBezierPath(rect: entryView.bounds).cgPath
    exampleView.layer.shadowPath = UIBezierPath(rect: exampleView.bounds).cgPath
  }
  
  private func changeButtonStackLength(isShort: Bool) {
    if isShort {
      buttonStackLeftCons.constant = margin * 2
      buttonStackRightCons.constant = margin * 2
    } else {
      buttonStackLeftCons.constant = margin
      buttonStackRightCons.constant = margin
    }
  }
  
  private func updateViewFromEntry() {
    // entry and example
    entryView.loadEntry(entry)
    if !entry.examples.isEmpty {
      exampleView.loadEntry(entry)
      exampleView.isHidden = false
    } else {
      exampleView.isHidden = true
    }
    // button
    switch method {
    case .wordList:
      forgetButton.isHidden = true
      continueButton.isHidden = true
    case .search:
      if record == nil {
        forgetButton.setTitle("Add", for: .normal)
        forgetButton.backgroundColor = Theme.tint
      } else {
        forgetButton.setTitle("Forget", for: .normal)
        forgetButton.backgroundColor = Theme.forgetButton
      }
      continueButton.isHidden = true
      forgetButton.isHidden = false
    case .failed, .passed:
      forgetButton.isHidden = true
      continueButton.isHidden = false
    }
  }
  
//  private func updateViewFromRecord() {
//    if let record = record {
//      noteView.loadNote(record.note)
//      noteView.isHidden = false
//    } else {
//      noteView.isHidden = true
//    }
//  }
  
  // MARK: - Data Interface
  func loadData(entry: JMEntry, method: openMethod, record: WordRecord? = nil) {
    self.entry = entry
    self.record = method == .search ? bookManager.getWordRecord(entryID: entry.id) : record
    self.method = method
    isDataLoaded = true
    if isViewLoaded {
      updateViewFromEntry()
      //updateViewFromRecord()
      reloadContentSize()
    }
  }
  
  // MARK: - Action
  @objc private func addOrForget() {
    if studyViewModel != nil {
      studyViewModel?.forget()
    } else {
      bookManager.addOrForget(entryID: entry.id)
    }
    forgetButton.backgroundColor = Theme.foreground
    forgetButton.setTitleColor(Theme.label, for: .normal)
    forgetButton.setTitle("Added to word book", for: .normal)
    forgetButton.layer.borderWidth = 1
    forgetButton.layer.borderColor = Theme.label.cgColor
    forgetButton.isEnabled = false
  }
  @objc private func processNext() {
    studyViewModel?.processNextQuiz()
  }
  
}
