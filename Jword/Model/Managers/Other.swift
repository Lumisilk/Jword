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
//  var isPresented: Bool {
//    return superview != nil
//  }
  static func addRadius(views: [UIView], radius: CGFloat) {
    for view in views {
      view.layer.cornerRadius = radius
    }
  }
}

