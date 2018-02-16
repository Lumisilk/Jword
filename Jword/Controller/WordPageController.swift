//
//  WordPageController.swift
//  Jword
//
//  Created by usagilynn on 2/10/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class WordPageController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var contentView: UIView!
  
  var entry: JMEntry!
  var entryView: EntryView!
  var exampleView: ExampleView!
  var noteView: NoteView!
  
  override func viewDidLoad() {
    entryView = EntryView(entry: entry)
    let exp = Array(entry.examples[0...2])
    exampleView = ExampleView(examples: exp)
    noteView = NoteView(note: "Some note")
    
    view.backgroundColor = ColorManager.background
    scrollView.backgroundColor = .clear
    contentView.backgroundColor = .clear
    contentView.addSubview(entryView)
    contentView.addSubview(exampleView)
    contentView.addSubview(noteView)
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    entryView.translatesAutoresizingMaskIntoConstraints = false
    exampleView.translatesAutoresizingMaskIntoConstraints = false
    noteView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: contentView.superview, attribute: .top, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .left, relatedBy: .equal, toItem: contentView.superview, attribute: .left, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: contentView.superview, attribute: .width, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: noteView, attribute: .bottom, multiplier: 1, constant: 14))
    
    contentView.addConstraints(sideConstraints(views: [entryView,exampleView,noteView]))
    contentView.addConstraint(NSLayoutConstraint(item: entryView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 14))
    contentView.addConstraint(NSLayoutConstraint(item: exampleView, attribute: .top, relatedBy: .equal, toItem: entryView, attribute: .bottom, multiplier: 1, constant: 14))
    contentView.addConstraint(NSLayoutConstraint(item: noteView, attribute: .top, relatedBy: .equal, toItem: exampleView, attribute: .bottom, multiplier: 1, constant: 14))
  }
  
  func sideConstraints(views: [UIView]) -> [NSLayoutConstraint] {
    var res = [NSLayoutConstraint]()
    for view in views {
      let c1 = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 15)
      let c2 = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -15)
      res.append(contentsOf: [c1,c2])
    }
    return res
  }
  
  override func viewDidAppear(_ animated: Bool) {
    scrollView.contentSize = contentView.frame.size
  }
  
}
