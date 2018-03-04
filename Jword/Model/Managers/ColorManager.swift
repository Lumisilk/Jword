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
  
  static var background: UIColor!
  static var frontBackground: UIColor!
  
  static var tint: UIColor!
  static var forgetButton: UIColor!
  //static var fail: UIColor!
  
  static var label: UIColor!
  static var line: UIColor!
  
  static var text: UIColor!
  static var subText: UIColor!
  
  static func setTheme(_ theme: Theme) {
    UserDefaults.standard.set(theme.rawValue, forKey: "theme")
    applyTheme()
  }
  
  static func applyTheme() {
    switch theme {
    case .night:
      break
    case .blue:
      //background = UIColor(red: 248/255, green: 248/255, blue: 255/255, alpha: 1) // light blue
      background = UIColor(r: 233, g: 244, b: 255) // light blue
      frontBackground = .white
      tint = UIColor(r: 34, g: 129, b: 255) // blue
      forgetButton = UIColor(r: 227, g: 55, b: 36)
      label = UIColor(r: 153, g: 153, b: 153)
      line = UIColor(r: 200, g: 200, b: 200)
      text = .black
      subText = .gray
    }
  }
  
}
