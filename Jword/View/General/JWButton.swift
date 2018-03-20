//
//  JWButton.swift
//  Jword
//
//  Created by usagilynn on 3/18/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class JWButton: ShrinkButton, Colorizable {
  
  enum ButtonType {
    case forget
    case normal
  }
  
  var title: String = ""
  var afterTitle: String = ""
  var type: ButtonType = .normal
  
  override var isEnabled: Bool {
    didSet {
      applyTheme()
    }
  }
  
  init(title: String, after: String, type: ButtonType) {
    self.title = title
    afterTitle = after
    self.type = type
    super.init(frame: CGRect.zero)
    initView()
    applyTheme()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initView()
  }
  
  func initView() {
    layer.cornerRadius = bounds.height/2
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOpacity = 0.2
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 14
    layer.shadowColor = UIColor.gray.cgColor
  }
  
  func applyTheme() {
    print("JWButton \(title) applyTheme")
    layer.borderColor = Theme.staticLabel.cgColor
    if isEnabled {
      titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .medium)
      backgroundColor = type == .normal ? Theme.normalButton: Theme.forgetButton
      tintColor = .white
      layer.borderWidth = 0
      layer.shadowOpacity = Theme.theme == .night ? 0: 0.2
      layer.borderWidth = 0
      titleLabel?.text = title
    } else {
      titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
      backgroundColor = Theme.foreground
      tintColor = Theme.staticLabel
      layer.shadowOpacity = 0
      layer.borderWidth = Theme.theme == .night ? 0 : 1
      titleLabel?.text = afterTitle
    }
  }
  
  func initial(title: String, after: String, type: ButtonType) {
    self.title = title
    afterTitle = after
    self.type = type
    applyTheme()
  }
}
