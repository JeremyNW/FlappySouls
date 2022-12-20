//
//  Boss.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 12/15/22.
//

import Foundation
import SpriteKit

class Boss: SKSpriteNode, GameObject {
    let maxHP = 50
    var hp = 50
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
        if hp < (maxHP / 5) {
            self.color = .angelRed
        }
    }
    
    func didCollide(with node: SKNode?) {
        if node is Hero {
            hp = 0
        } else if let node = node as? Bullet {
            hp -= node.damage
        } else {
            hp -= state.power
        }
        if hp <= 0 {
            die()
        }
    }
    
    func die() {
        self.removeFromParent()
    }
}
