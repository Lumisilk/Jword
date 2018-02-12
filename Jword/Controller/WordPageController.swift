//
//  WordPageController.swift
//  Jword
//
//  Created by usagilynn on 2/10/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

class WordPageController: UIViewController {

  @IBOutlet weak var kanjiLabel: UILabel!
  @IBOutlet weak var readingLabel: UILabel!
  @IBOutlet weak var senseTextView: UITextView!
  
  var entry: JMEntry!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }

  func configure() {
    kanjiLabel.text = entry.kanji
    readingLabel.text = entry.reading
    var text = ""
    for sense in entry.senses {
      for s in sense.senses {
        text += s + "\n"
      }
    }
    senseTextView.text = text
  }
  

}
