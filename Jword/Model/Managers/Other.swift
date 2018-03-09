//
//  TestManager.swift
//  Jword
//
//  Created by usagilynn on 2/9/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

extension Int {
  static func random(_ upper: Int) -> Int {
    return Int(arc4random_uniform(UInt32(upper)))
  }
}

extension Array {
  
  func randomPick(n: Int) -> [Element] {
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

extension UIView {
  var isPresented: Bool {
    return superview != nil
  }
  static func addRadius(views: [UIView], radius: CGFloat = 20) {
    for view in views {
      view.layer.cornerRadius = radius
    }
  }
  static func addShadows(views: [UIView]) {
    for view in views {
      view.layer.shadowColor = UIColor.gray.cgColor
      view.layer.shadowOpacity = 0.6
      view.layer.shadowOffset = CGSize(width: 0, height: 3)
      view.layer.shadowRadius = 14
    }
  }
  static func changeBackground(views: [UIView], color: UIColor) {
    for view in views {
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
