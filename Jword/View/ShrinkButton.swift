//
//  JWButton.swift
//  Jword
//
//  Created by usagilynn on 3/4/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

class ShrinkButton: UIButton {
  override var isHighlighted: Bool {
    didSet {
      let xScale : CGFloat = isHighlighted ? 0.95 : 1.0
      let yScale : CGFloat = isHighlighted ? 0.95 : 1.0
      UIView.animate(withDuration: 0.1) {
        self.transform = CGAffineTransform(scaleX: xScale, y: yScale)
      }
    }
  }
}
