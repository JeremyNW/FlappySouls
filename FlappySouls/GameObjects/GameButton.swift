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
  private var isProminent = false
  private var normalColor: UIColor { isProminent ? .buttonPurple : .darkGray  }
  private var tappedColor: UIColor { isProminent ? .angelPurple : .lightGray }
  
  func setUp(isProminent: Bool = false, action: @escaping () -> Void) {
    label = childNode(withName: "Label") as? SKLabelNode
    background = childNode(withName: "Sprite") as? SKSpriteNode
    background?.colorBlendFactor = 1
    isUserInteractionEnabled = true
    self.action = action
    self.isProminent = isProminent
    background?.color = normalColor
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    background?.yScale = -1
    background?.color = tappedColor
  }
  
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    background?.yScale = 1
    background?.color = normalColor
    action?()
  }
}
