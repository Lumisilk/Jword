//
//  WordPageController.swift
//  Jword
//
//  Created by usagilynn on 2/10/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

fileprivate let margin: CGFloat = 14

final class WordPageController: UIViewController {
  
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
  var entry: JMEntry!
  var record: WordRecord?
  var flag = true
  
  // MARK: - View
  override func viewDidLoad() {
    initView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    var size = stackView.frame.size
    size.height += margin * 2 + forgetButton.frame.height
    scrollView.contentSize = size
  }
  
  private func initView() {
    // navigationBar
//    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//    navigationController?.navigationBar.shadowImage = UIImage()
//    navigationController?.navigationBar.isTranslucent = true
//    navigationController?.view.backgroundColor = .clear
    // self view
    view.backgroundColor = ColorManager.background
    // stackView
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.alignment = .fill
    stackView.spacing = margin
    stackView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(stackView)
    // forgetButton
    forgetButton.layer.cornerRadius = 18
    forgetButton.backgroundColor = ColorManager.tint
    forgetButton.setTitle("Forget", for: .normal)
    forgetButton.setTitleColor(ColorManager.background, for: .normal)
    buttonStack.addArrangedSubview(forgetButton)
    
    // continueButton
    continueButton.layer.cornerRadius = 18
    continueButton.backgroundColor = .green
    continueButton.setTitle("Continue", for: .normal)
    continueButton.setTitleColor(ColorManager.background, for: .normal)
    buttonStack.addArrangedSubview(continueButton)
    
    // constraints
    view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: margin))
    view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: -margin * 2))
    
    view.bringSubview(toFront: buttonStack)
  }
  
  func loadWord(entry: JMEntry, record: WordRecord?) {
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
  }

  @IBAction func AddOrForget(_ sender: Any) {
    let s1 = JMSense()
    s1.gloss = "to sleep (not necessarily lying down)"
    let s2 = JMSense()
    s2.gloss = "to die"
    let s3 = JMSense()
    s3.gloss = "to lie idle (e.g. of resources)@to be dormant@to be unused"
    let s4 = JMSense()
    s4.gloss = "to close one's eyes"
    let e1 = JMEntry()
    e1.kanji = "眠い"
    e1.reading = "ねむい"
    e1.senses.append(objectsIn: [s1,s2,s3,s4])
    
    if flag {
      loadWord(entry: e1, record: nil)
    } else {
      loadWord(entry: entry, record: nil)
    }
    flag = !flag
  }
  
}
