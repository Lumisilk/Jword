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
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var forgetButton: UIButton!
  private let stackView = UIStackView()
  
  var entryView: EntryView? = nil
  var exampleView: ExampleView? = nil
  var noteView: NoteView? = nil
  
  var entry: JMEntry!
  //var record: WordRecord?
  
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
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.view.backgroundColor = .clear
    // self view
    view.backgroundColor = ColorManager.background
    // stackView
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.alignment = .fill
    stackView.spacing = margin
    stackView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(stackView)
    //entryView.translatesAutoresizingMaskIntoConstraints = false
    // forgetButton
    forgetButton.layer.cornerRadius = 18
    forgetButton.backgroundColor = ColorManager.tint
    forgetButton.setTitleColor(ColorManager.background, for: .normal)
    // constraints
    view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: margin))
    view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: -margin * 2))
  }
  
  func loadWord(entry: JMEntry, record: WordRecord?) {
    // entryView
    if let etView = entryView {
      etView.loadEntry(entry)
    } else {
      entryView = EntryView.init(entry: entry)
      stackView.addArrangedSubview(entryView!)
    }
    
    // exampleView
    if !entry.examples.isEmpty {
      let exp: [TNKExample] = entry.examples.count > 3 ? Array(entry.examples).randomPick(n: 3) : Array(entry.examples)
      
      if let expView = exampleView {
        expView.loadExamples(exp)
        if expView.superview == nil {
          stackView.addArrangedSubview(exampleView!)
        }
      } else {
        exampleView = ExampleView(examples: exp)
        stackView.addArrangedSubview(exampleView!)
      }
      
    } else if exampleView?.superview != nil {
      exampleView!.removeFromSuperview()
    }
    
    // noteView
    if let record = record {
      if let ntView = noteView {
        ntView.loadNote(record.note)
      } else {
        noteView = NoteView(note: record.note)
        //noteView!.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(noteView!)
      }
    } else if let ntView = noteView {
      ntView.removeFromSuperview()
      noteView = nil
    }
    
    view.bringSubview(toFront: forgetButton)
  }

  @IBAction func AddOrForget(_ sender: Any) {
    
  }
  
}
