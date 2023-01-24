//
//  ChompBoss.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 1/10/23.
//

import Foundation
import SpriteKit

class ChompBoss: SKSpriteNode, GameObject {
    weak var state: BossState!
    private var attackTimer = 420
    var isGoingUp = true
    var MBPosition = CGPoint(x: 240, y: 0)
    var YPosition = CGFloat(500)
    var movement = 0

    
    func miniChompAttack() {
        let miniBosses: [MiniBoss] = [
        MiniBoss(),
        MiniBoss(),
        MiniBoss(),
        MiniBoss(),
        MiniBoss()
        ]
        for miniBoss in miniBosses {
            scene!.addChild(miniBoss)
            miniBoss.enemyType = .chomp
            miniBoss.setUp(for: state)
            miniBoss.zPosition = 0
            miniBoss.position = MBPosition
            let move = SKAction.moveTo(y: YPosition, duration: 0.25)
            miniBoss.run(move)
            YPosition -= 250
        }
        YPosition = 500
    }

    func setUp(for state: GameState) {
        self.state = state as? BossState
        isHidden = true
    }
    
    func update(_ currentTime: TimeInterval) {
        if state.currentBoss == .bossOne {
            self.isHidden = false
            switch state.stateMachine {
                
            case .attacking:
                
                miniChompAttack()
                state.stateMachine = .moving
            case .entering:
                if position.x >= 240 {
                    position.x -= 3
                }
                if position.x <= 240 {
                    state.stateMachine = .moving
                }
            case .moving:
                position.y += CGFloat(movement)
                if position.y >= 600 {
                    isGoingUp = false
                }
                if position.y <= -600 {
                    isGoingUp = true
                }
                if isGoingUp {
                    movement = 5
                } else {
                    movement = -5
                }
            }
            if attackTimer != 0 {
                attackTimer -= 1
            } else {
                state.stateMachine = .attacking
                attackTimer += 420
            }
            
            
           
            if state.bossHealthPercentage < 20 {
                self.color = .angelRed
            }
        }
    }
    
    func didCollide(with node: SKNode?) {
        if state.stateMachine == .attacking || state.stateMachine == .moving && state.currentBoss == .bossOne {
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
    }
    func die() {
        self.removeFromParent()
        state.currentBoss = .bossTwo
        state.bossHealthPercentage = 50
        state.stateMachine = .entering
    }
}
