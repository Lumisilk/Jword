//
//  TestManager.swift
//  Jword
//
//  Created by usagilynn on 2/9/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

extension Array {
  
  func randomPick(n: Int) -> [Element] {
    var copy = self
    for i in stride(from: count-1, to: count-n-1, by: -1) {
      copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
    }
    return Array(copy.suffix(n))
  }
  
  mutating func shuffle() {
    guard count > 1 else { return }
    for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: count, to: 1, by: -1)) {
      let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
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
