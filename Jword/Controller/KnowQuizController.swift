//
//  KnowQuizController.swift
//  Jword
//
//  Created by usagilynn on 2/22/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class KnowQuizController: UIViewController {
  
  
  @IBOutlet weak var KnowButtonContainer: UIView!
  @IBOutlet weak var yesButton: UIButton!
  @IBOutlet weak var noButton: UIButton!
  
  
  override func viewDidLoad() {
    initView()
  }
  
  func initView() {
    UIView.addRadius(views: [KnowButtonContainer], radius: 13)
    KnowButtonContainer.backgroundColor = ColorManager.frontBackground
  }
  
}
