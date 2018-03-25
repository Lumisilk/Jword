//
//  NoteView.swift
//  Jword
//
//  Created by usagilynn on 2/14/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class NoteView: CardView, Colorizable {
  
  private let addLabel = UILabel()
  private let noteLabel = UILabel()
  private var addLabelConstraints = [NSLayoutConstraint]()
  private var noteLabelConstraints = [NSLayoutConstraint]()
  
  init(note: String) {
    super.init(title: "Note")
    initViews()
    loadNote(note)
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(title: "Note")
    initViews()
  }
  
  private func initViews() {
    
    addLabel.font = UIFont.systemFont(ofSize: 17)
    addLabel.text = "Add New Note"
    addLabel.translatesAutoresizingMaskIntoConstraints = false

    noteLabel.font = UIFont.systemFont(ofSize: 17)
    noteLabel.numberOfLines = 0
    noteLabel.lineBreakMode = .byWordWrapping
    noteLabel.translatesAutoresizingMaskIntoConstraints = false

    let addLabelX = NSLayoutConstraint(item: addLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
    let addLabelY = NSLayoutConstraint(item: addLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 15)
    addLabelConstraints = [addLabelX, addLabelY]
    
    let noteTop = NSLayoutConstraint(item: noteLabel, attribute: .top, relatedBy: .equal, toItem: line, attribute: .bottom, multiplier: 1, constant: topBottomMargin)
    let noteLeft = NSLayoutConstraint(item: noteLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin)
    let noteRight = NSLayoutConstraint(item: noteLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin)
    let selfBottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: noteLabel, attribute: .bottom, multiplier: 1, constant: topBottomMargin)
    noteLabelConstraints = [noteTop, noteLeft, noteRight, selfBottom]
    
    let selfHeight = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .height, multiplier: 0, constant: 100)
    addConstraint(selfHeight)
  }
  
  func loadNote(_ note: String) {
    print(note)
    if note.isEmpty {
      noteLabel.removeFromSuperview()
      if addLabel.superview == nil {
        addSubview(addLabel)
        print("addlabel")
        addConstraints(addLabelConstraints)
      }
    } else {
      addLabel.removeFromSuperview()
      noteLabel.text = note
      if noteLabel.superview == nil {
        addSubview(noteLabel)
        addConstraints(noteLabelConstraints)
      }
    }
  }
}
