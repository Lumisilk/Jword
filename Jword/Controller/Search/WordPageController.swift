//
//  WordPageController.swift
//  Jword
//
//  Created by usagilynn on 2/10/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

fileprivate let margin: CGFloat = 20

final class WordPageController: UIViewController {
  
  enum openMethod {
    case search
    case failed
    case passed
  }
  
  // MARK: View Property
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var stackView: UIStackView!
  //private let stackView = UIStackView()
  var entryView = EntryView(entry: nil)
  var exampleView = ExampleView(examples: [])
  var noteView = NoteView(note: nil)
  
  @IBOutlet weak var buttonStack: UIStackView!
  private let forgetButton = JWButton()
  private let continueButton = JWButton()
  
  @IBOutlet weak var buttonStackRightCons: NSLayoutConstraint!
  @IBOutlet weak var buttonStackLeftCons: NSLayoutConstraint!
  
  // MARK: Variable Property
  let bookManager = BookManager.shared()
  weak var studyManager: StudyManager?
  var entry: JMEntry!
  var record: WordRecord?
  
  // MARK: ViewController Method
  override func viewDidLoad() {
    initView()
    applyTheme()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    reloadscrollViewSize()
  }
  
  // MARK: View Method
  private func initView() {
    stackView.addArrangedSubview(entryView)
    stackView.addArrangedSubview(exampleView)
    stackView.addArrangedSubview(noteView)
    changeButtonStackLength(isShort: true)
    
    //UIView.addShadows(views: [forgetButton, continueButton])
    UIView.addRadius(views: [forgetButton,continueButton], radius: 18)
    forgetButton.addTarget(self, action: #selector(addOrForget), for: .touchUpInside)
    continueButton.setTitle("Continue", for: .normal)
    continueButton.addTarget(self, action: #selector(processNext), for: .touchUpInside)
    buttonStack.addArrangedSubview(forgetButton)
    buttonStack.addArrangedSubview(continueButton)
    view.bringSubview(toFront: buttonStack)
  }
  
  private func applyTheme() {
    view.backgroundColor = ColorManager.background
    forgetButton.setTitleColor(ColorManager.background, for: .normal)
    continueButton.backgroundColor = ColorManager.tint
  }
  
  private func reloadscrollViewSize() {
    view.layoutIfNeeded()
    var size = stackView.frame.size
    size.height += 14 + margin * 2 + buttonStack.frame.height
    scrollView.contentSize = size
    scrollView.setContentOffset(CGPoint.zero, animated: false)
  }
  
  private func updateRecord() {
    if let record = record {
      noteView.loadNote(record.note)
      noteView.isHidden = false
    } else {
      noteView.isHidden = true
    }
    if isViewLoaded {
      reloadscrollViewSize()
    }
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
  
  func load(entry: JMEntry, method: openMethod, record: WordRecord? = nil) {
    self.entry = entry
    self.record = method == .search ? bookManager.getWordRecord(entryID: entry.id) : record
    
    // entry and example
    entryView.loadEntry(entry)
    if !entry.examples.isEmpty {
      let exp: [TNKExample] = entry.examples.count > 3 ? Array(entry.examples).randomPick(n: 3) : Array(entry.examples)
      exampleView.loadExamples(exp)
      exampleView.isHidden = false
    } else {
      exampleView.isHidden = true
    }
    
    // button
    switch method {
    case .search:
      if record == nil {
        forgetButton.setTitle("Add", for: .normal)
        forgetButton.backgroundColor = ColorManager.tint
      } else {
        forgetButton.setTitle("Forget", for: .normal)
        forgetButton.backgroundColor = ColorManager.forgetButton
      }
      continueButton.isHidden = true
      forgetButton.isHidden = false
    case .failed, .passed:
      forgetButton.isHidden = true
      continueButton.isHidden = false
    }
    
    if isViewLoaded {
      reloadscrollViewSize()
    }
  }
  
  // MARK: Action Method
  @objc private func addOrForget() {
    if studyManager != nil {
      studyManager?.forget()
    } else {
      bookManager.addOrForget(entryID: entry.id)
    }
    forgetButton.backgroundColor = ColorManager.frontBackground
    forgetButton.setTitleColor(ColorManager.label, for: .normal)
    forgetButton.setTitle("Added to word book", for: .normal)
    forgetButton.layer.borderWidth = 1
    forgetButton.layer.borderColor = ColorManager.label.cgColor
    forgetButton.isEnabled = false
  }
  @objc private func processNext() {
    studyManager?.processNextQuiz()
  }
  
}
