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
  
  // view
  @IBOutlet weak var scrollView: UIScrollView!
  private let stackView = UIStackView()
  var entryView = EntryView(entry: nil)
  var exampleView = ExampleView(examples: [])
  var noteView = NoteView(note: nil)
  
  @IBOutlet weak var buttonStack: UIStackView!
  private let forgetButton = UIButton()
  private let continueButton = UIButton()
  
  
  // variable
  let bookManager = BookManager.shared()
  weak var studyManager: StudyManager?
  var entry: JMEntry!
  var record: WordRecord?
  var method: openMethod!
  var isPropertyLoaded = false
  
  // MARK: - View
  override func viewDidLoad() {
    initView()
    if isPropertyLoaded {
      loadPage()
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    var size = stackView.frame.size
    print(size.height)
    size.height += 14 + margin * 2 + buttonStack.frame.height
    scrollView.contentSize = size
  }
  
  private func initView() {
    // self view
    view.backgroundColor = ColorManager.background
    // stackView
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.alignment = .fill
    stackView.spacing = margin
    stackView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(stackView)
    
    UIView.addShadows(views: [forgetButton, continueButton])
    UIView.addRadius(views: [forgetButton,continueButton], radius: 18)
    // forgetButton
    forgetButton.backgroundColor = ColorManager.tint
    forgetButton.setTitle("Forget", for: .normal)
    forgetButton.setTitleColor(ColorManager.background, for: .normal)
    forgetButton.addTarget(self, action: #selector(addOrForget), for: .touchUpInside)
    // continueButton
    continueButton.backgroundColor = .green
    continueButton.setTitle("Continue", for: .normal)
    continueButton.setTitleColor(ColorManager.background, for: .normal)
    continueButton.addTarget(self, action: #selector(processNext), for: .touchUpInside)
    
    // constraints
    view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: margin))
    view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: margin))
    view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: -margin * 2))
  }
  
  private func loadPage() {
    // entryView
    entryView.loadEntry(entry)
    if !entryView.isPresented {
      stackView.addArrangedSubview(entryView)
    }

    // exampleView
    if !entry.examples.isEmpty {
      let exp: [TNKExample] = entry.examples.count > 3 ? Array(entry.examples).randomPick(n: 3) : Array(entry.examples)
      exampleView.loadExamples(exp)
      if !exampleView.isPresented {
        if stackView.arrangedSubviews.count == 2 {
          stackView.insertArrangedSubview(exampleView, at: 1)
        } else {
          stackView.addArrangedSubview(exampleView)
        }
      }
    } else {
      exampleView.removeFromSuperview()
    }
    
    // noteView
    if let record = record {
      noteView.loadNote(record.note)
      if !noteView.isPresented {
        stackView.addArrangedSubview(noteView)
      }
    } else {
      noteView.removeFromSuperview()
    }
    
    // buttonStack
    forgetButton.removeFromSuperview()
    continueButton.removeFromSuperview()
    switch method {
    case .search:
      buttonStack.addArrangedSubview(forgetButton)
    case .failed:
      buttonStack.addArrangedSubview(continueButton)
    case .passed:
      buttonStack.addArrangedSubview(forgetButton)
      buttonStack.addArrangedSubview(continueButton)
    default:
      break
    }
    view.bringSubview(toFront: buttonStack)
    viewDidAppear(false)
  }
  
  func load(entry: JMEntry, method: openMethod) {
    self.entry = entry
    self.method = method
    record = bookManager.getWordRecord(entryID: entry.id)
    if isViewLoaded {
      loadPage()
    }
    isPropertyLoaded = true
  }
  
  @objc private func addOrForget() {
    bookManager.addOrForget(entryID: entry.id)
  }
  @objc private func processNext() {
    studyManager?.processNextQuiz()
  }
  
}
