//
//  GameButton.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/1/22.
//

import Foundation
import SpriteKit

class GameButton: SKNode {
  private var label: SKLabelNode!
  private var background: SKSpriteNode!
  private var action: (() -> Void)?
  private var normalColor: UIColor = .white
  private var tappedColor: UIColor = .white
  
  func setUp(theme: GameButtonTheme, action: @escaping () -> Void) {
    label = childNode(withName: "Label") as? SKLabelNode
    background = childNode(withName: "Sprite") as? SKSpriteNode
    background?.colorBlendFactor = 1
    isUserInteractionEnabled = true
    self.action = action
    normalColor = theme.normalColor()
    tappedColor = theme.tappedColor()
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
  
  func setText(_ text: String) {
    label?.text = text
  }
}

enum GameButtonTheme {
  case primary, secondary
  func normalColor() -> UIColor {
    switch self {
    case .primary:
      return .angelDeepPurple
    case .secondary:
      return .angelGray
    }
  }
  
  func tappedColor() -> UIColor {
    switch self {
    case .primary:
      return .angelPurple
    case .secondary:
        return .angelPurple
    }
  }
}
