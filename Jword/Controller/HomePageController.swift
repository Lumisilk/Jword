//
//  HomePageController.swift
//  Jword
//
//  Created by usagilynn on 2/15/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

class HomePageController: UIViewController {

  var v: EntryView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let s1 = JMSense()
    s1.gloss = "to sleep (not necessarily lying down)"
    let s2 = JMSense()
    s2.gloss = "to die"
    let s3 = JMSense()
    s3.gloss = "to lie idle (e.g. of resources)@to be dormant@to be unused"
    let s4 = JMSense()
    s4.gloss = "to close one's eyes"
    let e1 = JMEntry()
    e1.kanji = "眠い"
    e1.reading = "ねむい"
    e1.senses.append(objectsIn: [s1,s2,s3,s4])

//    let sense2 = ["1-1", "A rabbit to jump very very very very very very very hiiiiiiiigh", "bunny", "4-1@4-2"]
//    let entry2 = JMEntry(kanji: "兎", reading: "うさぎ", senses: sense2)
    
    v = EntryView(entry: e1)
    view.addSubview(v)
    
    view.backgroundColor = ColorManager.background
    v.translatesAutoresizingMaskIntoConstraints = false
    let top = NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50)
    let left = NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 14)
    let right = NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -14)
    view.addConstraints([top, left, right])
  }

}
