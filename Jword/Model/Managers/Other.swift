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
    for i in stride(from: count - 1, to: count - n - 1, by: -1) {
      copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
    }
    return Array(copy.suffix(n))
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

