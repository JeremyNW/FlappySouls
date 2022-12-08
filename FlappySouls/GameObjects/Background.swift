//
//  Background.swift
//  FlappySouls
//
//  Created by Paola Warren on 12/7/22.
//

import Foundation
import SpriteKit

class Background: SKNode, GameObject {
  var bg: [SKNode] = []
  var mg: [SKNode] = []
  var fg: [SKNode] = []

  func setUp(for state: GameState) {
    guard
    let bg0 = childNode(withName: "bg0"),
    let bg1 = childNode(withName: "bg1"),
    let mg0 = childNode(withName: "mg0"),
    let mg1 = childNode(withName: "mg1"),
    let fg0 = childNode(withName: "fg0"),
    let fg1 = childNode(withName: "fg1")
    else { return }
    bg = [bg0, bg1]
    mg = [mg0, mg1]
    fg = [fg0, fg1]
//    bg.forEach { $0.isHidden = true }
  }
  
  func update(_ currentTime: TimeInterval) {
    bg.forEach { $0.position.x -= 0.25 }
    mg.forEach { $0.position.x -= 0.5 }
    fg.forEach { $0.position.x -= 1 }

    children.forEach {
      if $0.position.x <= -750 {
        $0.position.x = 750
      }
    }
  }
  
  func didCollide(with node: SKNode?) {
    
  }
  
  
}
