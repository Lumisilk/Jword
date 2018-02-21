//
//  NoteView.swift
//  Jword
//
//  Created by usagilynn on 2/14/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class NoteView: CardView {
  
  private let addNoteButton = UIButton()
  private let noteTextView = UITextView()
  private var buttonConstraints = [NSLayoutConstraint]()
  private var textViewConstraints = [NSLayoutConstraint]()
  
  init(note: String?) {
    super.init(title: "ノート")
    initViews()
    loadNote(note)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initViews() {
    noteTextView.isScrollEnabled = false
    noteTextView.font = UIFont.systemFont(ofSize: 14)
    noteTextView.isEditable = false
    noteTextView.translatesAutoresizingMaskIntoConstraints = false
    
    addNoteButton.setTitle("Add a note", for: .normal)
    addNoteButton.setTitleColor(.black, for: .normal)
    addNoteButton.backgroundColor = UIColor.clear
    addNoteButton.translatesAutoresizingMaskIntoConstraints = false
    
    let buttonTop = NSLayoutConstraint(item: addNoteButton, attribute: .top, relatedBy: .equal, toItem: line, attribute: .bottom, multiplier: 1, constant: 0)
    let buttonLeft = NSLayoutConstraint(item: addNoteButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
    let buttonRight = NSLayoutConstraint(item: addNoteButton, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
    let buttonHeight = NSLayoutConstraint(item: addNoteButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 100)
    let selfBottom1 = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: addNoteButton, attribute: .bottom, multiplier: 1, constant: 0)
    buttonConstraints = [buttonTop, buttonLeft, buttonRight, buttonHeight, selfBottom1]
    
    let noteTop = NSLayoutConstraint(item: noteTextView, attribute: .top, relatedBy: .equal, toItem: line, attribute: .bottom, multiplier: 1, constant: 3)
    let noteLeft = NSLayoutConstraint(item: noteTextView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin)
    let noteRight = NSLayoutConstraint(item: noteTextView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin)
    let selfBottom2 = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: noteTextView, attribute: .bottom, multiplier: 1, constant: topBottomMargin)
    textViewConstraints = [noteTop, noteLeft, noteRight, selfBottom2]
  }
  
  func loadNote(_ note: String?) {
    if let note = note {
      addNoteButton.removeFromSuperview()
      noteTextView.text = note
      if noteTextView.superview == nil {
        addSubview(noteTextView)
        addConstraints(textViewConstraints)
      }
    } else {
      noteTextView.removeFromSuperview()
      if addNoteButton.superview == nil {
        addSubview(addNoteButton)
        addConstraints(buttonConstraints)
      }
    }
    
  }
  
}
