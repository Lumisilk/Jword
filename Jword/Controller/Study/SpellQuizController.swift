//
//  SpellQuizController.swift
//  Jword
//
//  Created by usagilynn on 2/22/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class SpellQuizController: UIViewController {
  
  @IBOutlet weak var senseContainer: UIView!
  private var dot = ColorDot(color: ColorManager.tint)
  @IBOutlet weak var senseLabel: UILabel!
  @IBOutlet weak var quizContainer: UIView!
  @IBOutlet weak var quizLabel: UILabel!
  @IBOutlet weak var inputContainer: UIView!
  @IBOutlet weak var inputTextField: UITextField!
  @IBOutlet weak var forgetButton: ShrinkButton!
  @IBOutlet weak var confirmButton: ShrinkButton!
  
  weak var studyManager: StudyManager?
  var entry: JMEntry!
  var answer: String = ""
  
  override func viewDidLoad() {
    initView()
    applyTheme()
  }
  
  private func initView() {
    UIView.addRadius(views: [senseContainer, quizContainer, inputContainer, forgetButton, confirmButton])
    dot.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func applyTheme() {
    view.backgroundColor = ColorManager.background
    senseContainer.backgroundColor = ColorManager.frontBackground
    quizContainer.backgroundColor = ColorManager.frontBackground
    inputContainer.backgroundColor = ColorManager.frontBackground
    forgetButton.backgroundColor = ColorManager.forgetButton
    forgetButton.setTitleColor(ColorManager.frontBackground, for: .normal)
    confirmButton.backgroundColor = ColorManager.tint
    confirmButton.setTitleColor(ColorManager.frontBackground, for: .normal)
  }
  
  func load(entry: JMEntry) {
    self.entry = entry
    updateView()
  }
  
  private func updateView() {
    senseLabel.text = entry.firstGlossToLabelText()
    senseLabel.textColor = ColorManager.subText
    
    senseContainer.addSubview(dot)
    senseContainer.addConstraints(dot.sizeConstraints())
    let t: CGFloat = (senseLabel.font.lineHeight - 14)/2
    senseContainer.addConstraint(NSLayoutConstraint(item: dot, attribute: .top, relatedBy: .equal, toItem: senseLabel, attribute: .top, multiplier: 1, constant: t))
    senseContainer.addConstraint(NSLayoutConstraint(item: dot, attribute: .left, relatedBy: .equal, toItem: senseContainer, attribute: .left, multiplier: 1, constant: 14))
    
    if let (quiz, answer) = entry.pickQuiz() {
      quizLabel.text = quiz
      self.answer = answer
      quizContainer.isHidden = false
    } else {
      self.answer = entry.kanji
      quizContainer.isHidden = true
    }
  }

  @IBAction func pressForget(_ sender: Any) {
    studyManager?.forget()
    studyManager?.showWordPage(method: .failed)
  }
  
  @IBAction func pressConfirm(_ sender: Any) {
    guard let reply = inputTextField.text else { return }
    switch reply {
    case answer:
      // exactly correct
      studyManager?.pass()
      studyManager?.showWordPage(method: .passed)
    case entry.kanji:
      // partially correct
      break
    default:
      // wrong
      break
    }
  }
  
  
}
