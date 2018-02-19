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
  var contentView: UIView = UIView()
  
  var entryView: EntryView!
  var exampleView: ExampleView? = nil
  var noteView: NoteView? = nil
  //var reloadableConstraints: [NSLayoutConstraint] = []
  
  var entry: JMEntry!
  var record: WordRecord?
  
  // MARK: - View
  override func viewDidLoad() {

    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.view.backgroundColor = .clear
    
    // self view
    view.backgroundColor = ColorManager.background
    contentView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(contentView)
    // entryView
    entryView = EntryView(entry: entry)
    entryView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(entryView)
    // exampleView
    if !entry.examples.isEmpty {
      var exp: [TNKExample]
      if entry.examples.count > 3 {
        exp = Array(entry.examples).randomPick(n: 3)
      } else {
        exp = Array(entry.examples)
      }
      exampleView = ExampleView(examples: exp)
      exampleView!.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(exampleView!)
    }
    // noteView
    if let record = record {
      noteView = NoteView(note: record.note)
      noteView!.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(noteView!)
    }
    // forgetButton
    forgetButton.layer.cornerRadius = 18
    forgetButton.backgroundColor = ColorManager.tint
    forgetButton.setTitleColor(ColorManager.background, for: .normal)
    view.bringSubview(toFront: forgetButton)
    
    // constraints
    contentView.addConstraint(NSLayoutConstraint(item: entryView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 5))
    contentView.addConstraints(sideConstraints(views: [entryView]))
    view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0))
    
    switch (exampleView, noteView) {
    case (let expView?, let ntView?):
      contentView.addConstraint(NSLayoutConstraint(item: expView, attribute: .top, relatedBy: .equal, toItem: entryView, attribute: .bottom, multiplier: 1, constant: margin))
      contentView.addConstraint(NSLayoutConstraint(item: ntView, attribute: .top, relatedBy: .equal, toItem: expView, attribute: .bottom, multiplier: 1, constant: 14))
      contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: ntView, attribute: .bottom, multiplier: 1, constant: margin))
      contentView.addConstraints(sideConstraints(views: [expView, ntView]))
    case (let expView?, nil):
      contentView.addConstraint(NSLayoutConstraint(item: expView, attribute: .top, relatedBy: .equal, toItem: entryView, attribute: .bottom, multiplier: 1, constant: margin))
      contentView.addConstraints(sideConstraints(views: [expView]))
      contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: expView, attribute: .bottom, multiplier: 1, constant: margin))
    case (nil, let ntView?):
      contentView.addConstraint(NSLayoutConstraint(item: ntView, attribute: .top, relatedBy: .equal, toItem: entryView, attribute: .bottom, multiplier: 1, constant: margin))
      contentView.addConstraints(sideConstraints(views: [ntView]))
      contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: ntView, attribute: .bottom, multiplier: 1, constant: margin))
    case (nil,nil):
      contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: entryView, attribute: .bottom, multiplier: 1, constant: margin))
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    var size = contentView.frame.size
    size.height += 44
    scrollView.contentSize = size
  }
  
  private func sideConstraints(views: [UIView]) -> [NSLayoutConstraint] {
    var res = [NSLayoutConstraint]()
    for view in views {
      let c1 = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: margin)
      let c2 = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -margin)
      res.append(contentsOf: [c1,c2])
    }
    return res
  }
  
}
