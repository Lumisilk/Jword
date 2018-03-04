//
//  HomePageController.swift
//  Jword
//
//  Created by usagilynn on 2/15/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class HomePageController: UIViewController {

  @IBOutlet weak var jwButton: JWButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = ColorManager.background
    
    UIView.addRadius(views: [jwButton])
    jwButton.backgroundColor = ColorManager.tint
    jwButton.setTitle("Forget", for: .normal)
    jwButton.setTitleColor(ColorManager.background, for: .normal)
    //jwButton.addTarget(self, action: #selector(addOrForget), for: .touchUpInside)
  }

}
