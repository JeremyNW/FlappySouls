//
//  PauseView.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/11/22.
//

import Foundation
import SpriteKit

class PauseView: SKNode, GameObject {
  var state: GameState!
  var label: SKNode?
  var button: GameButton?
  
  func setUp(for state: GameState) {
    self.state = state
    button = childNode(withName: "PauseButton") as? GameButton
    button?.setUp(theme: .light) { [weak self] in
      self?.label?.isHidden.toggle()
      self?.scene?.isPaused.toggle()
    }
    label = childNode(withName: "PauseLabel")
    label?.isHidden = true
  }
  
  func update(_ currentTime: TimeInterval) {
    button?.isHidden = state.isDead
    label?.isHidden = scene?.isPaused == false
  }
  
  func didCollide(with node: SKNode?) {
    
  }
}
