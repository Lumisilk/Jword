//
//  KnowOrNotView.swift
//  Jword
//
//  Created by usagilynn on 2/20/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

class KnowOrNotView: UIView {
  
  @IBOutlet weak var yesButton: UIButton!
  @IBOutlet weak var noButton: UIButton!

  override func awakeFromNib() {
    initView()
  }
  
  private func initView() {
    self.layer.cornerRadius = 13
    self.backgroundColor = ColorManager.frontBackground
  }
}
