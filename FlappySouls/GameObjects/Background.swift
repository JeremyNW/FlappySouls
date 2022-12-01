//
//  Background.swift
//  FlappySouls
//
//  Created by Jared Warren on 11/28/22.
//

import Foundation
import SpriteKit

class Background: SKNode, GameObject {
  func setUp(with controller: GameController) {
    
  }
  
  func update(_ currentTime: TimeInterval) {
    var speed: CGFloat = 2.0
    for child in children {
      for tree in child.children {
        tree.position.x -= speed
        if tree.position.x <= -887 {
          tree.position.x = 1161
        }
      }
      speed -= 0.6
    }
  }
  
  func didCollide(with body: SKPhysicsBody) {
    
  }
}
