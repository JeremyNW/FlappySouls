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
    var isGoingUp = false
    var movement = 5
    func setUp(for state: GameState) {
        self.state = state as? BossState
    }
    
    func update(_ currentTime: TimeInterval) {
        
        switch state.stateMachine {
        case .attacking:
            let move = SKAction.moveTo(x: -640, duration: 1)
            let rotate = SKAction.rotate(byAngle: CGFloat.pi, duration: 2)
            let moveAndRotate = SKAction.group([rotate, move])
            self.run(moveAndRotate)
        case .entering:
            if position.x >= 240 {
                position.x -= 3
            }
            if position.x <= 240 {
                state.stateMachine = .moving
            }
        case .moving:
            position.y += CGFloat(movement)

            if state.heroPosition.y > position.y {
                movement = -5
            }
            if state.heroPosition.y < position.y {
                movement = 5
            }
            if position.y >= 540 {
                movement = -5
            }
            if position.y <= -540 {
                movement = 5
            }
            
            if position.x > 240 && attackTimer != 0 {
                position.x -= 3
            }
        }
        if attackTimer == 0 {
            state.stateMachine = .attacking
        } else if state.stateMachine != .entering {
            attackTimer -= 1
            state.stateMachine = .moving
        }
        if position.x < -500 {
            self.position.x = 320
            state.stateMachine = .entering
            attackTimer = 420
        }
        if state.bossHealthPercentage < 20 {
            self.color = .angelRed
        }
    }
    
    func didCollide(with node: SKNode?) {
        if state.stateMachine == .moving {
            if node is BossHero {
                state.bossHealthPercentage = 0
            } else if let node = node as? Bullet {
                state.bossHealthPercentage -= node.damage
            } else {
                state.bossHealthPercentage -= state.power
            }
        }
        if state.bossHealthPercentage <= 0 {
            die()
        }
    }
    
    func die() {
        self.removeFromParent()
        state.bossHealthPercentage = 50
        state.currentBoss = .bossOne
        state.stateMachine = .entering
    }
}
