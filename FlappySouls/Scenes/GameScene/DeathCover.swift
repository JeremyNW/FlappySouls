//
//  DeathCover.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/6/22.
//

import Foundation
import SpriteKit

class DeathCover: SKNode, GameObject {
  var state: GameState!
  func setUp(for state: GameState) {
    self.state = state
    (childNode(withName: "PlayAgain") as? GameButton)?.setUp(theme: .purple) { [weak self] in
      guard let scene = SKScene(fileNamed: "GameScene") else { return }
      scene.scaleMode = .aspectFit
      self?.scene?.view?.presentScene(scene, transition: .flipHorizontal(withDuration: 0.4))
    }
    (childNode(withName: "MainMenu") as? GameButton)?.setUp(theme: .light) { [weak self] in
      guard let scene = SKScene(fileNamed: "MainScene") else { return }
      scene.scaleMode = .aspectFit
      self?.scene?.view?.presentScene(scene, transition: .doorsCloseHorizontal(withDuration: 0.4))
    }
  }
  
  func update(_ currentTime: TimeInterval) {
    isHidden = !state.isDead
  }
  
  func didCollide(with node: SKNode?) {
    
  }
}