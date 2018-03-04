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
  private let stackView = UIStackView()
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
  var method: openMethod!
  var isPropertyLoaded = false
  
  // MARK: ViewController Method
  override func viewDidLoad() {
    initView()
    if isPropertyLoaded {
      loadPage()
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    reloadSize()
  }
  
  // MARK: View Method
  private func initView() {
    // stackView
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.alignment = .fill
    stackView.spacing = margin
    stackView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(stackView)
    
    //UIView.addShadows(views: [forgetButton, continueButton])
    UIView.addRadius(views: [forgetButton,continueButton], radius: 18)
    // forgetButton
    
    changeButtonStackLength(isShort: true)
    forgetButton.addTarget(self, action: #selector(addOrForget), for: .touchUpInside)
    continueButton.setTitle("Continue", for: .normal)
    continueButton.addTarget(self, action: #selector(processNext), for: .touchUpInside)
    
    // constraints
    view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: margin))
    view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: margin))
    view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: -margin * 2))
    
    applyTheme()
  }
  
  private func applyTheme() {
    view.backgroundColor = ColorManager.background
    forgetButton.setTitleColor(ColorManager.background, for: .normal)
    continueButton.backgroundColor = ColorManager.tint
  }
  
  private func reloadSize() {
    view.layoutIfNeeded()
    var size = stackView.frame.size
    size.height += 14 + margin * 2 + buttonStack.frame.height
    scrollView.contentSize = size
    scrollView.setContentOffset(CGPoint.zero, animated: false)
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
      if record == nil {
        forgetButton.setTitle("Add", for: .normal)
        forgetButton.backgroundColor = ColorManager.tint
      } else {
        forgetButton.setTitle("Forget", for: .normal)
        forgetButton.backgroundColor = ColorManager.forgetButton
      }
      buttonStack.addArrangedSubview(forgetButton)
    case .failed, .passed:
      buttonStack.addArrangedSubview(continueButton)
    default:
      break
    }
    
    view.bringSubview(toFront: buttonStack)
    reloadSize()
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
  
  func load(entry: JMEntry, record: WordRecord?, method: openMethod) {
    self.entry = entry
    self.method = method
    self.record = record
    if isViewLoaded {
      loadPage()
    }
    isPropertyLoaded = true
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
