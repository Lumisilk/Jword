//
//  ColorDot.swift
//  Jword
//
//  Created by usagilynn on 2/14/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class ColorDot: UIView {
  
  init(color: UIColor) {
    super.init(frame: CGRect(x: 0, y: 0, width: 5, height: 15))
    backgroundColor = color
    layer.cornerRadius = 1
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func sizeConstraints() -> [NSLayoutConstraint] {
    let c1 = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 15)
    let c2 = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 0, constant: 5)
    return [c1,c2]
  }

}
