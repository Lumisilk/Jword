//
//  BarItem.swift
//  Jword
//
//  Created by usagilynn on 3/10/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class JWBarItem: UIBarButtonItem {
  
  let button = UIButton()
  
  init(isHomeButtonOrSearch: Bool, target: Selector) {
    super.init()
    if isHomeButtonOrSearch {
      button.setImage(#imageLiteral(resourceName: "home.png"), for: .normal)
      button.addTarget(self, action: target, for: .touchUpInside)
    }
    customView = button
    let currWidth = customView?.widthAnchor.constraint(equalToConstant: 24)
    currWidth?.isActive = true
    let currHeight = customView?.heightAnchor.constraint(equalToConstant: 24)
    currHeight?.isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
