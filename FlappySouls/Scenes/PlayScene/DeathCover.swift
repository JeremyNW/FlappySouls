//
//  DeathCover.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/6/22.
//

import Foundation
import SpriteKit

class DeathCover: SKNode, GameObject {
  weak var state: PlayState!
  func setUp(for state: GameState) {
    self.state = state as? PlayState
    (childNode(withName: "PlayAgain") as? GameButton)?.setUp(theme: .primary) { [weak self] in
      guard let scene = SKScene(fileNamed: "PlayScene") else { return }
      scene.scaleMode = .aspectFit
      self?.scene?.view?.presentScene(scene, transition: .flipHorizontal(withDuration: 0.4))
    }
    (childNode(withName: "MainMenu") as? GameButton)?.setUp(theme: .secondary) { [weak self] in
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
