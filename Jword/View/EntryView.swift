//
//  EntryView.swift
//  Jword
//
//  Created by usagilynn on 2/15/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

class EntryView: CardView {
  
  private let verticalSpace: CGFloat = 4
  private let senseSpace: CGFloat = 10
  
  private let kanjiLabel = UILabel()
  private let readingLabel = UILabel()
  private var dots: [ColorDot] = []
  private var senseLabels: [UILabel] = []
  private var otherConstraints: [NSLayoutConstraint] = []
  
  init(entry: JMEntry) {
    super.init(title: nil)
    initView()
    loadEntry(entry)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initView() {
    // initial Views
    kanjiLabel.font = UIFont.systemFont(ofSize: 36)
    kanjiLabel.textColor = .black
    kanjiLabel.lineBreakMode = .byWordWrapping
    kanjiLabel.numberOfLines = 0
    kanjiLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(kanjiLabel)
    readingLabel.font = UIFont.systemFont(ofSize: 19)
    readingLabel.textColor = .gray
    readingLabel.lineBreakMode = .byWordWrapping
    readingLabel.numberOfLines = 0
    readingLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(readingLabel)
    
    // initial Constraints
    addConstraint(NSLayoutConstraint(item: kanjiLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: bottomMargin))
    addConstraint(NSLayoutConstraint(item: kanjiLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin))
    addConstraint(NSLayoutConstraint(item: kanjiLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin))
    addConstraint(NSLayoutConstraint(item: readingLabel, attribute: .top, relatedBy: .equal, toItem: kanjiLabel, attribute: .bottom, multiplier: 1, constant: verticalSpace))
    addConstraint(NSLayoutConstraint(item: readingLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin))
    addConstraint(NSLayoutConstraint(item: readingLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin))
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
    
    for (i,sense) in entry.senses.enumerated() {
      
      // reload views
      let dot = ColorDot(color: ColorManager.tint)
      dot.translatesAutoresizingMaskIntoConstraints = false
      dots.append(dot)
      addSubview(dot)
      
      let label = UILabel()
      label.text = sense.gloss.replacingOccurrences(of: "@", with: "\n")
      label.font = UIFont.systemFont(ofSize: 17)
      label.textColor = .gray
      label.lineBreakMode = .byWordWrapping
      label.numberOfLines = 0
      label.translatesAutoresizingMaskIntoConstraints = false
      senseLabels.append(label)
      addSubview(label)
      
      // reload constraints
      otherConstraints.append(NSLayoutConstraint(item: dot, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin))
      otherConstraints.append(contentsOf: dot.sizeConstraints())
      
      otherConstraints.append(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: dots[0], attribute: .right, multiplier: 1, constant: 10))
      otherConstraints.append(NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin))
      
      if i == 0 {
        otherConstraints.append(NSLayoutConstraint(item: dot, attribute: .top, relatedBy: .equal, toItem: readingLabel, attribute: .bottom, multiplier: 1, constant: verticalSpace * 3))
      } else {
        otherConstraints.append(NSLayoutConstraint(item: dot, attribute: .top, relatedBy: .equal, toItem: senseLabels[i-1], attribute: .bottom, multiplier: 1, constant: senseSpace))
      }
      
      let t: CGFloat = (label.font.lineHeight - 14)/2
      otherConstraints.append(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: dot, attribute: .top, multiplier: 1, constant: -t))
    }
    
    otherConstraints.append(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: senseLabels.last!, attribute: .bottom, multiplier: 1, constant: bottomMargin))
    
    addConstraints(otherConstraints)
  }
}
