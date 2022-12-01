//
//  GameButton.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/1/22.
//

import Foundation
import SpriteKit

class GameButton: SKNode {
  private var label: SKLabelNode?
  private var background: SKSpriteNode?
  private var action: (() -> Void)?
  
  func setUp(action: @escaping () -> Void) {
    label = childNode(withName: "Label") as? SKLabelNode
    background = childNode(withName: "Sprite") as? SKSpriteNode
    self.action = action
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    background?.yScale = -1
    background?.color = .darkGray
  }
  
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    background?.yScale = 1
    background?.color = .systemGray
    action?()
  }
}
