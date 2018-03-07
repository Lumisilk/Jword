//
//  HomeButton.swift
//  Jword
//
//  Created by usagilynn on 3/6/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class HomeButton: ShrinkButton {
  
  enum Entrance {
    case wordToday
    case study
    case search
    case setting
  }
  
  private let sideMargin: CGFloat = 16
  private let topMargin: CGFloat = 16
  
  let mainLabel = UILabel()
  let subLabel = UILabel()
  var subTitle: String = ""
  
  init() {
    super.init(frame: CGRect.zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initView()
  }
  
  private func initView() {
    imageView?.tintColor = ColorManager.homeButtonTint
    imageView?.contentMode = .scaleAspectFit
    let leftInset = bounds.width * 0.3
    imageEdgeInsets = UIEdgeInsetsMake(10, leftInset, 10, 0)
    
    mainLabel.textColor = ColorManager.frontBackground
    mainLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    mainLabel.adjustsFontSizeToFitWidth = true
    subLabel.textColor = ColorManager.frontBackground
    subLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    subLabel.textAlignment = .right
    
    mainLabel.translatesAutoresizingMaskIntoConstraints = false
    subLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(mainLabel)
    addSubview(subLabel)

    let mainTop = NSLayoutConstraint(item: mainLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: topMargin)
    let mainLeft = NSLayoutConstraint(item: mainLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin)
    let mainRight = NSLayoutConstraint(item: mainLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin)
    let subLeft = NSLayoutConstraint(item: subLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin)
    let subRight = NSLayoutConstraint(item: subLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin)
    let subBottom = NSLayoutConstraint(item: subLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -topMargin)

    addConstraints([mainTop, mainLeft, mainRight, subLeft, subRight, subBottom])

    let gradientLayer = CAGradientLayer()
    gradientLayer.cornerRadius = 10
    gradientLayer.colors = [ColorManager.gradientStartColor.cgColor, ColorManager.gradientEndColor.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.frame = self.bounds
    layer.insertSublayer(gradientLayer, at: 0)
    
    UIView.addShadows(views: [self])
  }
  
  func load(type: Entrance, subtitle: String = "") {
    subLabel.text = subTitle
    var origImage: UIImage?
    switch type {
    case .wordToday:
      mainLabel.text = "Words Today"
      origImage = UIImage(named: "book.png")
    case .study:
      mainLabel.text = "Study"
      origImage = UIImage(named: "pen.png")
    case .search:
      mainLabel.text = "Search"
      origImage = UIImage(named: "search.png")
    case .setting:
      mainLabel.text = "Setting"
      origImage = UIImage(named: "setting.png")
    }
    let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
    setImage(tintedImage, for: .normal)
  }
}
