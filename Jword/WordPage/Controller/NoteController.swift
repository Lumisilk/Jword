//
//  NoteController.swift
//  Jword
//
//  Created by usagilynn on 3/24/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import UIKit

final class NoteController: UIViewController, UIBarPositioningDelegate, Colorizable {

  @IBOutlet weak var noteTextField: UITextField!
  
  var note = ""
  var noteDidConfirm: ((String) -> ())?
  
  override func viewDidLoad() {
    noteTextField.text = note
    Theme.addObserver(controller: self)
    noteTextField.becomeFirstResponder()
  }
  
  func applyTheme() {
    view.backgroundColor = Theme.background
    noteTextField.backgroundColor = Theme.background
  }
  
  @IBAction func `return`(_ sender: Any) {
    noteTextField.resignFirstResponder()
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func noteConfirm(_ sender: Any) {
    noteTextField.resignFirstResponder()
    noteDidConfirm?(noteTextField.text!)
    dismiss(animated: true, completion: nil)
  }
  
  func load(note: String, didConfirm: @escaping (String)->()) {
    self.note = note
    noteDidConfirm = didConfirm
  }
  
  /// MARK: UIBarPositioningDelegate
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
}


