//
//  TestManager.swift
//  Jword
//
//  Created by usagilynn on 2/9/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

// MARK: - Fundation
extension Int {
  static func random(_ upper: Int) -> Int {
    return Int(arc4random_uniform(UInt32(upper)))
  }
}

extension Array {
  
  func randomPick(n: Int) -> [Element] {
    if n == count {
      return self.shuffled()
    } else if n > count {
      fatalError("n is bigger than count")
    }
    var copy = self
    for i in stride(from: count-1, to: count-n-1, by: -1) {
      copy.swapAt(i, Int.random(i+1))
    }
    return Array(copy.suffix(n))
  }
  
  mutating func shuffle() {
    guard count > 1 else { return }
    for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: count, to: 1, by: -1)) {
      let d: IndexDistance = Int.random(unshuffledCount)
      let i = index(firstUnshuffled, offsetBy: d)
      swapAt(firstUnshuffled, i)
    }
  }
  
  func shuffled() -> [Element] {
    var res = self
    res.shuffle()
    return res
  }
}

// MARK: - UIKit
extension Array where Element: UIView {
  func addRadius(_ radius: CGFloat = 20) {
    for view in self {
      view.layer.cornerRadius = radius
    }
  }
  func addShadows() {
    for view in self {
      view.layer.shadowColor = UIColor.gray.cgColor
      view.layer.shadowOpacity = 0.6
      view.layer.shadowOffset = CGSize(width: 0, height: 3)
      view.layer.shadowRadius = 14
    }
  }
  func changeBackground(color: UIColor) {
    for view in self {
      view.backgroundColor = color
    }
  }
}

extension UIStoryboard {
  static func instantiateController(identifier: String) -> UIViewController {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    return sb.instantiateViewController(withIdentifier: identifier)
  }
}

extension UIColor {
  convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1) {
    self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: alpha)
  }
}

extension UINavigationItem {
  func addHomeBarItem(action: Selector) {
    let button = UIButton()
    button.setImage(#imageLiteral(resourceName: "home.png"), for: .normal)
    button.addTarget(self, action: action, for: .touchUpInside)
    let barItem = UIBarButtonItem(customView: button)
    barItem.customView?.widthAnchor.constraint(equalToConstant: 25).isActive = true
    barItem.customView?.heightAnchor.constraint(equalToConstant: 25).isActive = true
    leftBarButtonItem = barItem
  }
  
  func addSearchBarItem(action: Selector) {
    let button = UIButton()
    button.setImage(#imageLiteral(resourceName: "search.png"), for: .normal)
    button.addTarget(self, action: action, for: .touchUpInside)
    let barItem = UIBarButtonItem(customView: button)
    barItem.customView?.widthAnchor.constraint(equalToConstant: 25).isActive = true
    barItem.customView?.heightAnchor.constraint(equalToConstant: 25).isActive = true
    rightBarButtonItem = barItem
  }
}
