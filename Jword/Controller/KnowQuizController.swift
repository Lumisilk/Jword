//
//  KnowQuizController.swift
//  Jword
//
//  Created by usagilynn on 2/22/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class KnowQuizController: UIViewController {
  
  
  @IBOutlet weak var progressContainer: UIView!
  var progressView: ProgressView!
  
  @IBOutlet weak var labelContainer: UIView!
  @IBOutlet weak var kanjiLabel: UILabel!
  @IBOutlet weak var easyButton: UIButton!
  
  @IBOutlet weak var KnowButtonContainer: UIView!
  @IBOutlet weak var yesButton: UIButton!
  @IBOutlet weak var noButton: UIButton!
  
  
  override func viewDidLoad() {
    kanjiLabel.text = "さようなら"
    let pv = UINib(nibName: "ProgressView", bundle: nil).instantiate(withOwner: nil, options: nil).first! as! ProgressView
    pv.frame = progressContainer.bounds
    progressView = pv
    pv.load(total: 50, learnt: 25, failed: 24)
    progressContainer.addSubview(pv)
    initView()
  }
  
  private func initView() {
    view.backgroundColor = ColorManager.background
    UIView.addRadius(views: [progressView, labelContainer, easyButton, KnowButtonContainer], radius: 13)
    UIView.addShadows(views: [progressView, labelContainer, easyButton, KnowButtonContainer])
    easyButton.backgroundColor = ColorManager.frontBackground
    KnowButtonContainer.backgroundColor = ColorManager.frontBackground
  }
  
  func loadKanji(_ kanji: String) {
    kanjiLabel.text = kanji
  }
  
}
