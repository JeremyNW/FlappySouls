//
//  Boss.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 12/15/22.
//

import Foundation
import SpriteKit

class EyeBoss: SKSpriteNode, GameObject {
    weak var state: BossState!
    private var attackTimer = 420
    
    func setUp(for state: GameState) {
        self.state = state as? BossState
    }
    
    func update(_ currentTime: TimeInterval) {
        
        
        if attackTimer != 0 {
            attackTimer -= 1
        } else {
            let move = SKAction.moveTo(x: -640, duration: 1)
            let rotate = SKAction.rotate(byAngle: CGFloat.pi, duration: 2)
            let moveAndRotate = SKAction.group([move, rotate])
            self.run(moveAndRotate)
        }
        
        if position.x > 240 && attackTimer != 0 {
            position.x -= 3
        }
        if position.x < -500 {
            self.position.x = 320
            attackTimer = 420
        }
        
        if state.bossHealthPercentage < 20 {
            self.color = .angelRed
        }
    }
    
    func didCollide(with node: SKNode?) {
        
            if node is BossHero {
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
        state.bossHealthPercentage = 100
        state.currentBoss = .bossOne
    }
}
