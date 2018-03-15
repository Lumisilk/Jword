//
//  CardView.swift
//  Jword
//
//  Created by usagilynn on 2/14/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

class CardView: UIView {
  
  internal let sideMargin: CGFloat = 16
  internal let topBottomMargin: CGFloat = 14
  internal let leftMarginForStack: CGFloat = 29
  internal let verticalBigSpace: CGFloat = 10
  internal let verticalSmallSpace: CGFloat = 4
  
  let titleLabel = UILabel()
  internal let line = UIView()
  
  init(title: String) {
    super.init(frame: CGRect.zero)
    initView(title)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initView(_ title: String) {
    [self].addRadius()
    if !title.isEmpty {
      titleLabel.text = title
      titleLabel.font = UIFont.systemFont(ofSize: 13)
      titleLabel.frame = CGRect(x: 16, y: 9, width: 50, height: 13)
      addSubview(titleLabel)
      addSubview(line)
      
      line.translatesAutoresizingMaskIntoConstraints = false
      let lineTop = NSLayoutConstraint(item: line, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8)
      let lineLeft = NSLayoutConstraint(item: line, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
      let lineRight = NSLayoutConstraint(item: line, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
      let lineHeight = NSLayoutConstraint(item: line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 1)
      addConstraints([lineTop, lineLeft, lineRight, lineHeight])
    }
  }
  
  func applyTheme() {
    backgroundColor = Theme.foreground
    titleLabel.textColor = Theme.label
    line.backgroundColor = Theme.label
  }
  
}
