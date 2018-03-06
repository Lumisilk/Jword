//
//  ColorManager.swift
//  Jword
//
//  Created by usagilynn on 2/14/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class ColorManager {
  
  enum Theme: Int {
    case night = 0
    case blue = 1
  }
  
  static var theme: Theme {
    if let value = UserDefaults.standard.value(forKey: "theme") as? Int {
      return Theme(rawValue: value)!
    } else {
      return .blue
    }
  }
  
  /// A background color used mostly.
  static var background: UIColor!
  
  /// Like card view's background, or label's color in view whose background color is blod.
  static var frontBackground: UIColor!
  
  /// A bold color close to main theme.
  static var tint: UIColor!
  
  /// A bold color contrasts to main theme.
  static var forgetButton: UIColor!

  static var label: UIColor!
  static var line: UIColor!
  
  /// A color for main text, usually is black.
  static var text: UIColor!
  /// A color for sub text, usually is gray.
  static var subText: UIColor!
  
  static var gradientStartColor: UIColor!
  static var gradientEndColor: UIColor!
  
  static func setTheme(_ theme: Theme) {
    UserDefaults.standard.set(theme.rawValue, forKey: "theme")
    applyTheme()
  }
  
  static func applyTheme() {
    switch theme {
    case .night:
      break
    case .blue:
      background = UIColor(r: 233, g: 244, b: 255) // light blue
      frontBackground = .white
      tint = UIColor(r: 34, g: 129, b: 255) // bold blue
      forgetButton = UIColor(r: 227, g: 55, b: 36) // light red
      label = UIColor(r: 153, g: 153, b: 153)
      line = UIColor(r: 200, g: 200, b: 200)
      text = .black
      subText = .gray
      
      gradientStartColor = UIColor(r: 71, g: 183, b: 255)
      gradientEndColor = UIColor(r: 34, g: 129, b: 255)

    }
  }
  
}
