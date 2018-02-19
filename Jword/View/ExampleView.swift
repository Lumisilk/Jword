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
  private let betweenExampleSpace: CGFloat = 15
  
  // SubViews
  private var dots = [ColorDot]()
  private var japLabels = [UILabel]()
  private var engLabels = [UILabel]()
  private var otherConstraints = [NSLayoutConstraint]()
  
  init(examples: [TNKExample]) {
    super.init(title: "例文")
    loadExamples(examples)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
    
    for (i,exp) in examples.enumerated() {
      
      // reload views
      let dot = ColorDot(color: ColorManager.tint)
      dot.translatesAutoresizingMaskIntoConstraints = false
      dots.append(dot)
      addSubview(dot)
      
      let japLabel = UILabel()
      japLabel.text = exp.japanese
      japLabel.font = UIFont.systemFont(ofSize: 17)
      japLabel.textColor = ColorManager.text
      japLabel.lineBreakMode = .byWordWrapping
      japLabel.numberOfLines = 0
      japLabel.translatesAutoresizingMaskIntoConstraints = false
      japLabels.append(japLabel)
      addSubview(japLabel)
      
      let engLabel = UILabel()
      engLabel.text = exp.english
      engLabel.font = UIFont.systemFont(ofSize: 17)
      engLabel.textColor = ColorManager.subText
      engLabel.lineBreakMode = .byWordWrapping
      engLabel.numberOfLines = 0
      engLabel.translatesAutoresizingMaskIntoConstraints = false
      engLabels.append(engLabel)
      addSubview(engLabel)
      
      // reload constraints
      otherConstraints.append(NSLayoutConstraint(item: dot, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin))
      otherConstraints.append(contentsOf: dot.sizeConstraints())
      
      if i == 0 {
        otherConstraints.append(NSLayoutConstraint(item: dot, attribute: .top, relatedBy: .equal, toItem: line  , attribute: .bottom, multiplier: 1, constant: dotLabelSpace))
      } else {
        otherConstraints.append(NSLayoutConstraint(item: dot, attribute: .top, relatedBy: .equal, toItem: engLabels[i-1], attribute: .bottom, multiplier: 1, constant: betweenExampleSpace))
      }
      
      otherConstraints.append(NSLayoutConstraint(item: japLabel, attribute: .left, relatedBy: .equal, toItem: dot, attribute: .right, multiplier: 1, constant: 10))
      otherConstraints.append(NSLayoutConstraint(item: japLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin))
      
      let t: CGFloat = (japLabel.font.lineHeight - 14)/2
      otherConstraints.append(NSLayoutConstraint(item: japLabel, attribute: .top, relatedBy: .equal, toItem: dot, attribute: .top, multiplier: 1, constant: -t))
      otherConstraints.append(NSLayoutConstraint(item: engLabel, attribute: .top, relatedBy: .equal, toItem: japLabel, attribute: .bottom, multiplier: 1, constant: japEngLabelSpace))
      otherConstraints.append(NSLayoutConstraint(item: engLabel, attribute: .left, relatedBy: .equal, toItem: japLabel, attribute: .left, multiplier: 1, constant: 0))
      otherConstraints.append(NSLayoutConstraint(item: engLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin))
    }
    
    otherConstraints.append(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: engLabels.last!, attribute: .bottom, multiplier: 1, constant: bottomMargin))
    
    addConstraints(otherConstraints)
  }
  
}

