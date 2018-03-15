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
  
  case night = 0
  case blue = 1
  
  static private var observers = [WeakObserver]()
  static private var theme: Theme {
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
  
  /// A bold color close to main theme.
  static var tint: UIColor = .clear
  
  /// A bold color contrasts to main theme.
  static var forgetButton: UIColor = .clear

  static var label: UIColor = .clear
  static var line: UIColor = .clear
  
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
  }
  
  static func applyTheme() {
    switch theme {
    case .night:
      break
    case .blue:
      background = UIColor(r: 233, g: 244, b: 255) // light blue
      foreground = .white
      tint = UIColor(r: 34, g: 129, b: 255) // bold blue
      forgetButton = UIColor(r: 227, g: 55, b: 36) // light red
      label = UIColor(r: 153, g: 153, b: 153)
      line = UIColor(r: 200, g: 200, b: 200)
      text = .black
      subText = .gray
      homeButtonTint = UIColor(r: 55, g: 111, b: 181)
      gradientStartColor = UIColor(r: 71, g: 183, b: 255)
      gradientEndColor = UIColor(r: 34, g: 129, b: 255)
    }
    UINavigationBar.appearance().barTintColor = Theme.background
    UINavigationBar.appearance().tintColor = Theme.tint
    UISearchBar.appearance().barTintColor = Theme.background
  }
  
  static func addObserver(view: Colorizable) {
    if observers.count >= 10 {
      observers = observers.filter{$0.view != nil}
    }
    Theme.observers.append(WeakObserver(view))
    view.applyTheme()
  }
  
  static private func notifyObserver() {
    for observer in observers {
      if let view = observer.view {
        view.applyTheme()
      }
    }
  }
  
  
}

struct WeakObserver {
  weak var view: Colorizable?
  init(_ view: Colorizable) {
    self.view = view
  }
}
