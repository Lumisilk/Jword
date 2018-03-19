//
//  ColorManager.swift
//  Jword
//
//  Created by usagilynn on 2/14/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

protocol Colorizable: class {
  func applyTheme()
}

enum Theme: Int {
  
  // MARK: - Theme
  case night = 0
  case blue = 1
  case pink = 2
  
  static var theme: Theme {
    if let value = UserDefaults.standard.value(forKey: "theme") as? Int {
      return Theme(rawValue: value)!
    } else {
      return .blue
    }
  }
  
  /// A background color used mostly.
  static var background: UIColor = .clear
  
  /// Like card view's background, or label's color in view whose background color is blod.
  static var foreground: UIColor = .clear
  
  static var barStyle: UIBarStyle = .default
  
  /// A bold color close to main theme.
  static var tint: UIColor = .clear
  
  /// A bold color contrasts to main theme.
  static var forgetButton: UIColor = .clear

  static var staticLabel: UIColor = .clear
  
  /// A color for main text, usually is black.
  static var text: UIColor = .clear
  /// A color for sub text, usually is gray.
  static var subText: UIColor = .clear
  
  static var homeButtonTint: UIColor = .clear
  static var gradientStartColor: UIColor = .clear
  static var gradientEndColor: UIColor = .clear
  
  static func setTheme(_ theme: Theme) {
    UserDefaults.standard.set(theme.rawValue, forKey: "theme")
    applyTheme()
    notifyObserver()
  }
  
  static func applyTheme() {
    barStyle = .default
    staticLabel = UIColor(r: 115, g: 115, b: 115)
    switch theme {
    case .night:
      barStyle = .blackOpaque
      background = .black
      foreground = UIColor(r: 82, g: 82, b: 82)
      tint = UIColor(r: 252, g: 159, b: 77)
      forgetButton = UIColor(r: 227, g: 55, b: 36)
      staticLabel = UIColor(r: 170, g: 170, b: 170)
      text = .white
      subText = UIColor(r: 220, g: 220, b: 220)
      homeButtonTint = UIColor(r: 55, g: 111, b: 181)
      gradientStartColor = UIColor(r: 71, g: 183, b: 255)
      gradientEndColor = UIColor(r: 34, g: 129, b: 255)
    case .blue:
      background = UIColor(r: 227, g: 239, b: 254)
      foreground = .white
      tint = UIColor(r: 57, g: 124, b: 255)
      forgetButton = UIColor(r: 226, g: 88, b: 88)
      text = .black
      subText = .gray
      homeButtonTint = UIColor(r: 55, g: 111, b: 181)
      gradientStartColor = UIColor(r: 71, g: 183, b: 255)
      gradientEndColor = UIColor(r: 34, g: 129, b: 255)
    case .pink:
      background = UIColor(r: 254, g: 223, b: 225)
      foreground = .white
      tint = UIColor(r: 232, g: 86, b: 115)
      forgetButton = .white
      text = .black
      subText = .gray
      homeButtonTint = UIColor(r: 158, g: 60, b: 61)
      gradientStartColor = UIColor(r: 242, g: 94, b: 94)
      gradientEndColor = UIColor(r: 217, g: 84, b: 84)
    }
    //UINavigationBar.appearance().barTintColor = Theme.background
    //UINavigationBar.appearance().tintColor = Theme.tint
    //UISearchBar.appearance().barTintColor = Theme.background
  }
  
  static func switchTheme() {
    var i = theme.rawValue
    i = i == 2 ? 0 : i+1
    setTheme(Theme(rawValue: i)!)
  }
  
  // MARK: - Observation
  static private var observers = [WeakReference]()
  
  static func addObserver(controller: Colorizable) {
    if observers.count >= 10 {
      observers = observers.filter{$0.object != nil}
    }
    Theme.observers.append(WeakReference(controller))
    controller.applyTheme()
  }
  
  static private func notifyObserver() {
    UIView.animate(withDuration: 0.3) {
      for observer in observers {
        if let view = observer.object {
          view.applyTheme()
        }
      }
    }
  }
}


