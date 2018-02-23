//
//  progressView.swift
//  Jword
//
//  Created by usagilynn on 2/23/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class ProgressView: UIView {
  
  @IBOutlet weak var learntView: UIView!
  @IBOutlet weak var waitView: UIView!
  @IBOutlet weak var failedView: UIView!
  
  @IBOutlet weak var learntLabel: UILabel!
  @IBOutlet weak var waitLabel: UILabel!
  @IBOutlet weak var failedLabel: UILabel!
  
  @IBOutlet weak var learntWidth: NSLayoutConstraint!
  @IBOutlet weak var failedWidth: NSLayoutConstraint!
  
  private var totalWidth: CGFloat = 0
  
  var totalCount: Int = 1
  var learntCount: Int = 0
  var failedCount: Int = 0
  var waitedCount: Int {
    return totalCount - learntCount - failedCount
  }
  
  init() {
    fatalError("init() has not been implemented")
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    initView()
    print("progress awakeFromNib")
  }
  
  private func initView() {
    UIView.addRadius(views: [learntView, failedView], radius: 10)
    learntView.backgroundColor = ColorManager.tint
    waitView.backgroundColor = .clear
    failedView.backgroundColor = ColorManager.fail
    learntWidth.constant = 0
    failedWidth.constant = 0
  }
  
  func load(total: Int, learnt: Int, failed: Int) {
    totalWidth = bounds.width
    
    let needRefreshLearnt = totalCount != total || learntCount != learnt
    let needRefreshFailed = totalCount != total || failedCount != failed
    let needRefreshWaited = totalCount != total || learntCount != learnt || failedCount != failed
    totalCount = total
    learntCount = learnt
    failedCount = failed
    
    if needRefreshLearnt {
      let newWidth: CGFloat = totalWidth * CGFloat(Float(learnt)/Float(totalCount))
      learntWidth.constant = newWidth
      learntLabel.text = learnt.description
      learntLabel.isHidden = learntLabel.bounds.width > newWidth
    }
    if needRefreshFailed {
      let newWidth: CGFloat = totalWidth * CGFloat(Float(failed)/Float(totalCount))
      failedWidth.constant = newWidth
      failedLabel.text = failed.description
      failedLabel.isHidden = failedLabel.bounds.width > newWidth
    }
    if needRefreshWaited {
      waitLabel.text = waitedCount.description
      waitLabel.isHidden = waitLabel.bounds.width > waitView.bounds.width
    }
  }
}
