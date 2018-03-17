//
//  Other.swift
//  Jword
//
//  Created by usagilynn on 3/17/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class ShakeDetectingWindow: UIWindow {
  override public func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
    if motion == .motionShake {
      Theme.switchTheme()
      return
    }
    super.motionEnded(motion, with: event)
  }
}

struct WeakReference {
  weak var object: Colorizable?
  init(_ object: Colorizable) {
    self.object = object
  }
}

