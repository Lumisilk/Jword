//
//  SpellQuizController.swift
//  Jword
//
//  Created by usagilynn on 3/17/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class SpellQuizController: UIViewController, Colorizable {
  
  @IBOutlet weak var senseContainer: UIView!
  private var dot = ColorDot(color: Theme.tint)
  @IBOutlet weak var senseLabel: UILabel!
  @IBOutlet weak var questionContainer: UIView!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var resultContainer: UIView!
  @IBOutlet weak var inputTextField: UITextField!
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var forgetButton: JWButton!
  @IBOutlet weak var confirmButton: JWButton!
  
  weak var studyViewModel: StudyCoordinator!
  var entry: JMEntry!
  var quiz: SpellQuiz!
  private var isResultShowing = false
  
  // MARK: - View Controller
  override func viewDidLoad() {
    initView()
    Theme.addObserver(controller: self)
  }
  
  private func initView() {
    [senseContainer, questionContainer, resultContainer].addRadius()
    dot.translatesAutoresizingMaskIntoConstraints = false
    forgetButton.initial(title: "Forget", after: "Forgotten", isNormal: false)
    confirmButton.initial(title: "Confirm", after: "Continue", isNormal: true)
  }
  
  func applyTheme() {
    view.backgroundColor = Theme.background
    [senseContainer, questionContainer, resultContainer].changeBackground(color: Theme.foreground)
    [senseLabel, questionLabel, resultLabel].changeTextColor(Theme.text)
    inputTextField.textColor = Theme.text
    forgetButton.applyTheme()
    confirmButton.applyTheme()
  }
  
  private func updateView() {
    senseLabel.text = entry.firstGlossToLabelText()
    senseContainer.addSubview(dot)
    senseContainer.addConstraints(dot.sizeConstraints())
    let t: CGFloat = (senseLabel.font.lineHeight - 14)/2
    senseContainer.addConstraint(NSLayoutConstraint(item: dot, attribute: .top, relatedBy: .equal, toItem: senseLabel, attribute: .top, multiplier: 1, constant: t))
    senseContainer.addConstraint(NSLayoutConstraint(item: dot, attribute: .left, relatedBy: .equal, toItem: senseContainer, attribute: .left, multiplier: 1, constant: 14))
    
    questionContainer.isHidden = !quiz.isHadSentence
    if quiz.isHadSentence { questionLabel.text = quiz.question }
    
    isResultShowing = false
    inputTextField.isEnabled = true
    inputTextField.isHidden = false
    inputTextField.text = ""
    resultLabel.isHidden = true
    forgetButton.isEnabled = true
    print("kanji:  \(entry.kanji)")
    print("reading:\(entry.reading)")
    print("answer: \(quiz.deformation)")
  }
  
  // MARK: - Data Interface
  func load(entry: JMEntry) {
    self.entry = entry
    quiz = SpellQuiz(entry: entry)
    updateView()
  }
  
  private func showResult(_ result: SpellQuiz.Result) {
    inputTextField.resignFirstResponder()
    inputTextField.isEnabled = false
    forgetButton.isEnabled = false
    resultLabel.isHidden = false
    let answer = quiz.correctAnswer()
    switch result {
    case .forget:
      inputTextField.isHidden = true
      resultLabel.text = "Answer: \(answer)"
      studyViewModel.forget()
    case .wrong:
      resultLabel.text = "Wrong\nAnswer: \(answer)"
      studyViewModel.forget()
    case .partialRight:
      resultLabel.text = "Partially right. It should be deformed.\nCorrect answer: \(answer)"
      studyViewModel.pass()
    case .right:
      resultLabel.text = "Excellent!"
      studyViewModel.pass()
    }
    isResultShowing = true
  }
  
  // MARK: - Action
  @IBAction func pressForget(_ sender: Any) {
    inputTextField.isHidden = true
    showResult(.forget)
  }
  
  @IBAction func pressConfirm(_ sender: Any) {
    if !isResultShowing {
      let result = quiz.result(input: inputTextField.text!)
      showResult(result)
    } else {
      studyViewModel.showWordPage(method: .passed)
    }
  }
  
}
