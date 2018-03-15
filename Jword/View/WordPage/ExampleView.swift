//
//  ExampleView.swift
//  Jword
//
//  Created by usagilynn on 2/13/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class ExampleView: CardView, Colorizable {
  
  // SubViews
  private let stackView = UIStackView()
  private var smallStacks: [UIStackView] = []
  
  private var dots = [ColorDot]()
  private var labels = [UILabel]()
  
  init() {
    super.init(title: "Example")
    initView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(title: "Example")
    initView()
  }
  
  private func initView() {
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.alignment = .fill
    stackView.spacing = verticalBigSpace
    stackView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(stackView)
    
    let stackTop = NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: line, attribute: .bottom, multiplier: 1, constant: topBottomMargin)
    let stackLeft = NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin + 15)
    let stackRight = NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin)
    let selfBottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: stackView, attribute: .bottom, multiplier: 1, constant: topBottomMargin)
    addConstraints([stackTop, stackLeft, stackRight, selfBottom])
  }
  
  override func applyTheme() {
    super.applyTheme()
    for label in labels {
      label.textColor = Theme.subText
    }
    for dot in dots {
      dot.backgroundColor = Theme.tint
    }
    
  }
  
  func loadEntry(_ entry: JMEntry) {
    
    smallStacks.forEach({$0.removeFromSuperview()})
    smallStacks.removeAll()
    dots.forEach({$0.removeFromSuperview()})
    dots.removeAll()
    labels.forEach({$0.removeFromSuperview()})
    labels.removeAll()
    
    let examples: [TNKExample] = entry.examples.count > 3 ? Array(entry.examples).randomPick(n: 3) : Array(entry.examples)
    
    for exp in examples {
      
      let newStack = UIStackView()
      newStack.axis = .vertical
      newStack.distribution = .equalSpacing
      newStack.alignment = .fill
      newStack.spacing = verticalSmallSpace
      smallStacks.append(newStack)
      stackView.addArrangedSubview(newStack)
      
      let japLabel = UILabel()
      let str = exp.coloredString(kanji: entry.kanji)
      japLabel.attributedText = str
      japLabel.lineBreakMode = .byWordWrapping
      japLabel.numberOfLines = 0
      labels.append(japLabel)
      newStack.addArrangedSubview(japLabel)
      
      let engLabel = UILabel()
      engLabel.text = exp.english
      engLabel.font = UIFont.systemFont(ofSize: 17)
      engLabel.textColor = Theme.subText
      engLabel.lineBreakMode = .byWordWrapping
      engLabel.numberOfLines = 0
      labels.append(engLabel)
      newStack.addArrangedSubview(engLabel)
      
      let dot = ColorDot(color: Theme.tint)
      dot.translatesAutoresizingMaskIntoConstraints = false
      dots.append(dot)
      addSubview(dot)
      
      let t: CGFloat = (japLabel.font.lineHeight - 14)/2
      let dotTop = NSLayoutConstraint(item: dot, attribute: .top, relatedBy: .equal, toItem: japLabel, attribute: .top, multiplier: 1, constant: t)
      let dotLeft = NSLayoutConstraint(item: dot, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin)
      addConstraints(dot.sizeConstraints())
      addConstraints([dotTop, dotLeft])
    }
  }
  
}
