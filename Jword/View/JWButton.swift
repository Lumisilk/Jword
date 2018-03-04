//
//  JWButton.swift
//  Jword
//
//  Created by usagilynn on 3/4/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

class JWButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: CGRect.zero)
    initView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initView()
  }
  
  private final func initView() {
    addTarget(self, action: #selector(shrink), for: .touchDown)
    addTarget(self, action: #selector(shrink), for: .touchDragInside)
    addTarget(self, action: #selector(recover), for: .touchDragOutside)
    addTarget(self, action: #selector(recover), for: .touchUpInside)
  }
  
  @objc private final func shrink() {
    UIView.animate(withDuration: TimeInterval(0.1)) {
      self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    }
  }
  
  @objc private final func recover() {
    UIView.animate(withDuration: TimeInterval(0.1)) {
      self.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
  }
  
}
