//
//  SpellQuiz.swift
//  Jword
//
//  Created by usagilynn on 3/17/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import Foundation

struct SpellQuiz {
  
  enum Result {
    case forget
    case wrong
    case partialRight
    case right
  }
  
  private let kanji: String
  private let reading: String
  
  var isHadSentence: Bool = true
  var isAnswerDeformed: Bool = true
  
  private var sentence: String = ""
  var question: String = ""
  var deformation: String = ""
  
  init(entry: JMEntry) {
    kanji = entry.kanji
    reading = entry.reading
    guard let example = entry.pickOneExample(), let idx = example.words.index(of: kanji) else {
      isHadSentence = false
      return
    }
    sentence = example.japanese
    deformation = example.deformations[idx]
    guard sentence.contains(deformation) else {
      isHadSentence = false
      return
    }
    
    var underline = ""
    let count = max(kanji.count, reading.count, deformation.count)
    underline =  String.init(repeating: "__", count: count)
    isAnswerDeformed = deformation != kanji && deformation != reading
    question = sentence.replacingOccurrences(of: deformation, with: underline)
  }
  
  func result(input: String) -> Result {
    guard !input.isEmpty else { return .forget }
    
    if !isHadSentence && (input == kanji || input == reading) {
      return .right
    }
    if isAnswerDeformed {
      switch input {
      case kanji, reading:
        return .partialRight
      case deformation:
        return .right
      default:
        return .wrong
      }
    } else {
      return (input == kanji || input == reading) ? .right: .wrong
    }
  }
  
  func correctAnswer() -> String {
    if !isHadSentence {
      return kanji
    } else {
      return isAnswerDeformed ? deformation: kanji
    }
  }
}
