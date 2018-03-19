//
//  JWButton.swift
//  Jword
//
//  Created by usagilynn on 3/18/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class JWButton: ShrinkButton, Colorizable {
  
  var title: String = ""
  var afterTitle: String = ""
  var color: UIColor = .clear
  
  override var isEnabled: Bool {
    didSet {
      applyTheme()
    }
  }
  
  init(title: String, after: String, color: UIColor) {
    self.title = title
    afterTitle = after
    self.color = color
    super.init(frame: CGRect.zero)
    initView()
    applyTheme()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initView()
    applyTheme()
  }
  
  func initView() {
    titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .medium)
    layer.cornerRadius = bounds.height/2
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOpacity = 0.2
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 14
    layer.shadowColor = UIColor.gray.cgColor
  }
  
  func applyTheme() {
    if isEnabled {
      titleLabel?.text = title
      titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
      backgroundColor = color
      tintColor = .white
      layer.borderWidth = 0
      layer.shadowOpacity = Theme.theme == .night ? 0: 0.2
    } else {
      titleLabel?.text = afterTitle
      titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
      backgroundColor = Theme.foreground
      tintColor = Theme.staticLabel
      layer.shadowOpacity = 0
    }
    layer.borderColor = Theme.staticLabel.cgColor
    layer.borderWidth = Theme.theme == .night ? 0 : 1
  }
  
  func initial(title: String, after: String, color: UIColor) {
    self.title = title
    afterTitle = after
    self.color = color
    applyTheme()
  }
}
