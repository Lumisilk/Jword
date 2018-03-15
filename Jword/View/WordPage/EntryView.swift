//
//  EntryView.swift
//  Jword
//
//  Created by usagilynn on 2/15/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class EntryView: CardView, Colorizable {
  
  private let senseSpace: CGFloat = 10
  
  private let kanjiLabel = UILabel()
  private let readingLabel = UILabel()
  private let stackView = UIStackView()
  private var senseLabels: [UILabel] = []
  private var dots: [ColorDot] = []
  private var otherConstraints: [NSLayoutConstraint] = []
  
  init(entry: JMEntry?) {
    super.init(title: "")
    initView()
    if let entry = entry {
      loadEntry(entry)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(title: "")
    initView()
  }
  
  private func initView() {
    
    kanjiLabel.font = UIFont.systemFont(ofSize: 36)
    kanjiLabel.lineBreakMode = .byWordWrapping
    kanjiLabel.numberOfLines = 0
    kanjiLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(kanjiLabel)
    
    readingLabel.font = UIFont.systemFont(ofSize: 19)
    readingLabel.lineBreakMode = .byWordWrapping
    readingLabel.numberOfLines = 0
    readingLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(readingLabel)
    
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.alignment = .fill
    stackView.spacing = verticalSmallSpace
    stackView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(stackView)
    
    let kanjiTop = NSLayoutConstraint(item: kanjiLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: topBottomMargin)
    let kanjiLeft = NSLayoutConstraint(item: kanjiLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin)
    let kanjiRight = NSLayoutConstraint(item: kanjiLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin)
    let readingTop = NSLayoutConstraint(item: readingLabel, attribute: .top, relatedBy: .equal, toItem: kanjiLabel, attribute: .bottom, multiplier: 1, constant: verticalSmallSpace)
    let readingLeft = NSLayoutConstraint(item: readingLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin)
    let readingRight = NSLayoutConstraint(item: readingLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin)
    
    let stackTop = NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: readingLabel, attribute: .bottom, multiplier: 1, constant: verticalBigSpace)
    let stackLeft = NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin + 15)
    let stackRight = NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin)
    let selfBottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: stackView, attribute: .bottom, multiplier: 1, constant: topBottomMargin)
    
    addConstraints([kanjiTop, kanjiLeft, kanjiRight, readingTop, readingLeft, readingRight, stackTop, stackLeft, stackRight, selfBottom])
  }
  
  override func applyTheme() {
    super.applyTheme()
    kanjiLabel.textColor = Theme.text
    readingLabel.textColor = Theme.subText
    for label in senseLabels {
      label.textColor = Theme.subText
    }
    for dot in dots {
      dot.backgroundColor = Theme.tint
    }
  }
  
  func loadEntry(_ entry: JMEntry) {
    
    kanjiLabel.text = entry.kanji
    readingLabel.text = entry.reading
    
    dots.forEach({$0.removeFromSuperview()})
    dots.removeAll()
    senseLabels.forEach({$0.removeFromSuperview()})
    senseLabels.removeAll()
    removeConstraints(otherConstraints)
    otherConstraints.removeAll()
    
    for sense in entry.senses {
      
      let label = UILabel()
      label.text = sense.gloss.replacingOccurrences(of: "@", with: "\n")
      label.font = UIFont.systemFont(ofSize: 17)
      label.textColor = Theme.subText
      label.lineBreakMode = .byWordWrapping
      label.numberOfLines = 0
      senseLabels.append(label)
      stackView.addArrangedSubview(label)
      
      let dot = ColorDot(color: Theme.tint)
      dot.translatesAutoresizingMaskIntoConstraints = false
      dots.append(dot)
      addSubview(dot)
      
      // reload constraints
      otherConstraints.append(contentsOf: dot.sizeConstraints())
      let t: CGFloat = (label.font.lineHeight - 14)/2
      otherConstraints.append(NSLayoutConstraint(item: dot, attribute: .top, relatedBy: .equal, toItem: label, attribute: .top, multiplier: 1, constant: t))
      otherConstraints.append(NSLayoutConstraint(item: dot, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin))
    }
    addConstraints(otherConstraints)
  }
}

