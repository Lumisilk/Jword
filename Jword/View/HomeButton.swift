//
//  HomeButton.swift
//  Jword
//
//  Created by usagilynn on 3/6/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class HomeButton: JWButton {
  
  enum Entrance {
    case wordToday
    case study
    case search
    case setting
  }
  
  private let sideMargin: CGFloat = 14
  private let topMargin: CGFloat = 18
  
  let mainLabel = UILabel()
  let subLabel = UILabel()
  let backImage = UIImageView()
  let gradientLayer = CAGradientLayer()
  
  var subTitle: String = ""
  
  init() {
    
//    self.type = type
//    self.subTitle = subTitle
    super.init(frame: CGRect.zero)
//    initView()
//    load()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initView()
  }
  
  private func initView() {
    mainLabel.textColor = ColorManager.frontBackground
    mainLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    mainLabel.adjustsFontSizeToFitWidth = true
    subLabel.textColor = ColorManager.frontBackground
    subLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    subLabel.textAlignment = .right
    
    self.translatesAutoresizingMaskIntoConstraints = false
    mainLabel.translatesAutoresizingMaskIntoConstraints = false
    subLabel.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(mainLabel)
    addSubview(subLabel)

    let aspect = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .width, multiplier: 0.618, constant: 0)
    
    let mainTop = NSLayoutConstraint(item: mainLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: topMargin)
    let mainLeft = NSLayoutConstraint(item: mainLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin)
    let mainRight = NSLayoutConstraint(item: mainLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin)
    let subLeft = NSLayoutConstraint(item: subLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: sideMargin)
    let subRight = NSLayoutConstraint(item: subLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -sideMargin)
    let subBottom = NSLayoutConstraint(item: subLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -topMargin)
    
    addConstraints([aspect, mainTop, mainLeft, mainRight, subLeft, subRight, subBottom])
    
    gradientLayer.cornerRadius = 10
    gradientLayer.colors = [ColorManager.gradientStartColor.cgColor, ColorManager.gradientEndColor.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradientLayer.locations = [0.0, 1.0]
    layer.insertSublayer(gradientLayer, at: 0)
    
    UIView.addShadows(views: [self])
  }
  
  func load(type: Entrance, subtitle: String = "") {
    subLabel.text = subTitle
    switch type {
    case .wordToday:
      mainLabel.text = "Today's Words"
    case .study:
      mainLabel.text = "Study"
    case .search:
      mainLabel.text = "Search"
    case .setting:
      mainLabel.text = "Setting"
    }
    
  }
  
  func loadGradient() {
    gradientLayer.frame = self.bounds
  }
}
