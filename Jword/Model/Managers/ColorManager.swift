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
  
  //static let shared = ColorManager()
  
  private init() {
    ColorManager.applyTheme()
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
      background = UIColor(red: 248/255, green: 248/255, blue: 255/255, alpha: 1) // light blue
      frontBackground = UIColor.white
      tint = UIColor(red: 34/255, green: 129/255, blue: 255/255, alpha: 1) // sky blue
      label = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1) // gray
      line = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
      text = UIColor.black
      subText = UIColor.gray
      //subText = UIColor(red: 92/255, green: 92/255, blue: 92/255, alpha: 1) // light gray
    }
  }
  
}
