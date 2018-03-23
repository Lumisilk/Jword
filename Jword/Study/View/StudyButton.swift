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
  var isNormal: Bool = true
  
  override var isEnabled: Bool {
    didSet {
      applyTheme()
    }
  }
  
  init(title: String, after: String, isNormal: Bool) {
    self.title = title
    afterTitle = after
    self.isNormal = isNormal
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
    
    if isEnabled {
      
      titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .medium)
      titleLabel?.text = title
      if isNormal {
        tintColor = .white
        backgroundColor = Theme.tint
        layer.borderWidth = 0
        layer.shadowOpacity = Theme.theme == .night ? 0: 0.3
      } else {
        tintColor = Theme.tint
        backgroundColor = Theme.background
        layer.borderColor = Theme.tint.cgColor
        layer.borderWidth = 2
        layer.shadowOpacity = 0
      }
    } else {
      
      titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
      titleLabel?.text = afterTitle
      if isNormal {
        fatalError()
      }
      backgroundColor = Theme.foreground
      tintColor = Theme.staticLabel
      layer.borderColor = Theme.staticLabel.cgColor
      layer.shadowOpacity = 0
      layer.borderWidth = Theme.theme == .night ? 0 : 1
    }
  }
  
  func initial(title: String, after: String, isNormal: Bool) {
    self.title = title
    afterTitle = after
    self.isNormal = isNormal
    applyTheme()
  }
}
