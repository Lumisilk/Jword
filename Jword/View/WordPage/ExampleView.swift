//
//  ExampleView.swift
//  Jword
//
//  Created by usagilynn on 2/13/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

class ExampleView: CardView {
  
  // Margins
  private let dotLabelSpace: CGFloat = 18
  private let japEngLabelSpace: CGFloat = 5
  private let betweenExampleSpace: CGFloat = 10
  
  // SubViews
  private let stackView = UIStackView()
  
  private var dots = [ColorDot]()
  private var japLabels = [UILabel]()
  private var engLabels = [UILabel]()
  private var otherConstraints = [NSLayoutConstraint]()
  
  init(examples: [TNKExample]) {
    super.init(title: "例文")
    initView()
    loadExamples(examples)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initView() {
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.alignment = .fill
    stackView.spacing = betweenExampleSpace
    stackView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(stackView)
    
    let stackTop = NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: line, attribute: .bottom, multiplier: 1, constant: bottomMargin)
    let stackLeft = NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin + 15)
    let stackRight = NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin)
    let selfBottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: stackView, attribute: .bottom, multiplier: 1, constant: bottomMargin)
    addConstraints([stackTop, stackLeft, stackRight, selfBottom])
    
  }
  
  func loadExamples(_ examples: [TNKExample]) {
    
    dots.forEach({$0.removeFromSuperview()})
    dots.removeAll()
    japLabels.forEach({$0.removeFromSuperview()})
    japLabels.removeAll()
    engLabels.forEach({$0.removeFromSuperview()})
    engLabels.removeAll()
    removeConstraints(otherConstraints)
    otherConstraints.removeAll()
    
    for exp in examples {
      
      let japLabel = UILabel()
      japLabel.text = exp.japanese
      japLabel.font = UIFont.systemFont(ofSize: 17)
      japLabel.textColor = ColorManager.text
      japLabel.lineBreakMode = .byWordWrapping
      japLabel.numberOfLines = 0
      japLabels.append(japLabel)
      stackView.addArrangedSubview(japLabel)
      
      let engLabel = UILabel()
      engLabel.text = exp.english
      engLabel.font = UIFont.systemFont(ofSize: 17)
      engLabel.textColor = ColorManager.subText
      engLabel.lineBreakMode = .byWordWrapping
      engLabel.numberOfLines = 0
      engLabels.append(engLabel)
      stackView.addArrangedSubview(engLabel)
      
      let dot = ColorDot(color: ColorManager.tint)
      dot.translatesAutoresizingMaskIntoConstraints = false
      dots.append(dot)
      addSubview(dot)
      
      otherConstraints.append(contentsOf: dot.sizeConstraints())
      let t: CGFloat = (japLabel.font.lineHeight - 14)/2
      otherConstraints.append(NSLayoutConstraint(item: dot, attribute: .top, relatedBy: .equal, toItem: japLabel, attribute: .top, multiplier: 1, constant: t))
      otherConstraints.append(NSLayoutConstraint(item: dot, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin))
    }
    addConstraints(otherConstraints)
  }
  
}


