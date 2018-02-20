//
//  KnowOrNotView.swift
//  Jword
//
//  Created by usagilynn on 2/20/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

class KnowOrNotView: CardView {
  
  private let verticalSpace: CGFloat = 8
  
  init() {
    super.init(title: nil)
    initView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initView() {
    
    let yesButton = UIButton()
    yesButton.setTitle("Know", for: .normal)
    yesButton.setTitleColor(ColorManager.subText, for: .normal)
    yesButton.translatesAutoresizingMaskIntoConstraints = false
    
    line.translatesAutoresizingMaskIntoConstraints = false
    let lineCenterY = NSLayoutConstraint(item: line, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
    let lineLeft = NSLayoutConstraint(item: line, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
    let lineRight = NSLayoutConstraint(item: line, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
    let lineHeight = NSLayoutConstraint(item: line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 1)
    
  }
  
  
}
