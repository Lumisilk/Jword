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
  @IBOutlet weak var resultContainer: UIView!
  @IBOutlet weak var resultStack: UIStackView!
  @IBOutlet weak var inputTextField: UITextField!
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var forgetButton: ShrinkButton!
  @IBOutlet weak var confirmButton: ShrinkButton!
  private var isResultShowing = false
  
  weak var studyManager: StudyManager!
  var entry: JMEntry!
  var answer = ""
  var isAnswerDeformed = true
  
  // MARK: - ViewController
  override func viewDidLoad() {
    initView()
    applyTheme()
  }
  
  private func initView() {
    resultLabel.isHidden = true
    [senseContainer, quizContainer, resultContainer, forgetButton, confirmButton].addRadius()
    dot.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func applyTheme() {
    view.backgroundColor = ColorManager.background
    [senseContainer, quizContainer, resultContainer].changeBackground(color: ColorManager.foreground)
    senseLabel.textColor = ColorManager.subText
    forgetButton.backgroundColor = ColorManager.forgetButton
    forgetButton.setTitleColor(ColorManager.foreground, for: .normal)
    confirmButton.backgroundColor = ColorManager.tint
    confirmButton.setTitleColor(ColorManager.foreground, for: .normal)
  }
  
  private func updateView() {
    senseLabel.text = entry.firstGlossToLabelText()
    senseContainer.addSubview(dot)
    senseContainer.addConstraints(dot.sizeConstraints())
    let t: CGFloat = (senseLabel.font.lineHeight - 14)/2
    senseContainer.addConstraint(NSLayoutConstraint(item: dot, attribute: .top, relatedBy: .equal, toItem: senseLabel, attribute: .top, multiplier: 1, constant: t))
    senseContainer.addConstraint(NSLayoutConstraint(item: dot, attribute: .left, relatedBy: .equal, toItem: senseContainer, attribute: .left, multiplier: 1, constant: 14))
    
    if let (quiz, answer) = entry.pickQuiz() {
      quizLabel.text = quiz
      self.answer = answer
      isAnswerDeformed = (answer != entry.kanji && answer != entry.reading)
      quizContainer.isHidden = false
    } else {
      self.answer = entry.kanji
      isAnswerDeformed = false
      quizContainer.isHidden = true
    }
    isResultShowing = false
    inputTextField.isEnabled = true
    inputTextField.isHidden = false
    inputTextField.text = ""
    resultLabel.isHidden = true
    forgetButton.isHidden = false
    print("kanji:  \(entry.kanji)")
    print("reading:\(entry.reading)")
    print("answer: \(answer)")
  }
  
  enum Result {
    case forget
    case wrong
    case partiallyRight
    case right
  }
  private func showResult(_ result: Result) {
    inputTextField.isEnabled = false
    forgetButton.isHidden = true
    resultLabel.isHidden = false
    switch result {
    case .forget:
      resultLabel.text = "Answer: \(answer)"
      studyManager.forget()
    case .wrong:
      resultLabel.text = "Wrong\nAnswer: \(answer)"
      studyManager.forget()
    case .partiallyRight:
      resultLabel.text = "Partially right. It should be deformed.\nCorrect answer: \(answer)"
      studyManager.pass()
    case .right:
      resultLabel.text = "Excellent!"
      studyManager.pass()
    }
    isResultShowing = true
  }
  
  // MARK: - Data Interface
  func load(entry: JMEntry) {
    self.entry = entry
    updateView()
  }
  
  // MARK: - Action
  @IBAction func pressForget(_ sender: Any) {
    inputTextField.isHidden = true
    showResult(.forget)
  }
  
  @IBAction func pressConfirm(_ sender: Any) {
    if !isResultShowing {
      guard let reply = inputTextField.text else { return }
      if !isAnswerDeformed {
        if reply == entry.kanji || reply == entry.reading {
          showResult(.right)
        } else {
          showResult(.wrong)
        }
      } else {
        if reply == answer {
          showResult(.right)
        } else if reply == entry.kanji || reply == entry.reading {
          showResult(.partiallyRight)
        } else {
          showResult(.wrong)
        }
      }
    } else {
      studyManager.showWordPage(method: .passed)
    }
  }
  
  
}
