//
//  TestManager.swift
//  Jword
//
//  Created by usagilynn on 2/9/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

// MARK: - Custom
extension TNKExample {
  func coloredString(kanji: String) -> NSAttributedString {
    let str = NSMutableAttributedString(string: japanese)
    guard let idx = words.index(of: kanji) else { return str }
    let deform = deformations[idx]
    guard let nsRange = japanese.nsRange(subString: deform) else { return str }
    str.addAttribute(.foregroundColor, value: Theme.tint, range: nsRange)
    return str
  }
}

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

extension String {
  func nsRange(subString: String) -> NSRange? {
    guard let range = self.range(of: subString) else { return nil }
    let startPos = self.distance(from: self.startIndex, to: range.lowerBound)
    let endPos = self.distance(from: self.startIndex, to: range.upperBound)
    return NSMakeRange(startPos, endPos - startPos)
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
      view.layer.shadowOpacity = 0.2
      view.layer.shadowOffset = CGSize(width: 0, height: 3)
      view.layer.shadowRadius = 14
      //view.layer.shouldRasterize = true
    }
  }
  func changeBackground(color: UIColor) {
    for view in self {
      view.backgroundColor = color
    }
  }
}

extension Array where Element: UILabel {
  func changeTextColor(_ color: UIColor) {
    self.forEach {$0.textColor = color}
  }
}

extension Array where Element: Colorizable {
  func applyTheme() {
    forEach{$0.applyTheme()}
  }
}

extension UIStoryboard {
  static func instantiateController(name: String, id: String) -> UIViewController {
    let sb = UIStoryboard(name: name, bundle: nil)
    return sb.instantiateViewController(withIdentifier: id)
  }
}

extension UIColor {
  convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1) {
    self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: alpha)
  }
}

//extension UIView {
//  @IBInspectable var cornerRadius: CGFloat {
//    get { return layer.cornerRadius }
//    set { layer.cornerRadius = newValue }
//  }
//}

