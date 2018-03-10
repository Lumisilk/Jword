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
    if isHomeButtonOrSearch {
      button.setImage(#imageLiteral(resourceName: "home.png"), for: .normal)
      button.addTarget(self, action: target, for: .touchUpInside)
    }
    super.init(customView: button)
    let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
    currWidth?.isActive = true
    let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
    currHeight?.isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
