//
//  Boss.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 12/15/22.
//

import Foundation
import SpriteKit

class Boss: SKSpriteNode, GameObject {
    var state: GameState!
    
    func setUp(for state: GameState) {
        self.state = state
    }
    
    func update(_ currentTime: TimeInterval) {
        if position.y < state.heroPosition.y {
            position.y += 5
        } else {
            position.y -= 5
        }
        if state.bossHealthPercentage < 20 {
            self.color = .angelRed
        }
    }
    
    func didCollide(with node: SKNode?) {
        if node is Hero {
            state.bossHealthPercentage = 0
        } else if let node = node as? Bullet {
            state.bossHealthPercentage -= node.damage
        } else {
            state.bossHealthPercentage -= state.power
        }
        if state.bossHealthPercentage <= 0 {
            die()
        }
    }
    
    func die() {
        self.removeFromParent()
    }
}
