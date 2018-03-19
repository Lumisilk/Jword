//
//  JWButton.swift
//  Jword
//
//  Created by usagilynn on 3/18/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class JWButton: ShrinkButton, Colorizable {
  
  var titleOriginal: String = "Title"
  var titleAfter: String = "Title"
  var color: UIColor = .white
  
  override var isEnabled: Bool {
    didSet {
      updateViewFromIsEnable()
    }
  }
  
  init(title original: String, title after: String, color: UIColor) {
    titleOriginal = original
    titleAfter = after
    self.color = color
    super.init(frame: CGRect.zero)
    initView()
    updateViewFromIsEnable()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initView()
    updateViewFromIsEnable()
  }
  
  func initView() {
    layer.cornerRadius = 23
    layer.borderColor = UIColor.gray.cgColor
    [self].addShadows()
  }
  
  func applyTheme() {
    titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .medium)
  }
  
  func initial(title original: String, title after: String, color: UIColor) {
    titleOriginal = original
    titleAfter = after
    self.color = color
    updateViewFromIsEnable()
  }
  
  private func updateViewFromIsEnable() {
    if isEnabled {
      titleLabel?.text = titleOriginal
      tintColor = Theme.foreground
      backgroundColor = color
      layer.borderWidth = 0
    } else {
      titleLabel?.text = titleAfter
      tintColor = Theme.subText
      backgroundColor = Theme.foreground
      layer.borderWidth = 1
    }
  }
}
