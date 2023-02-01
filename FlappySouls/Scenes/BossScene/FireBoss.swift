//
//  FireBoss.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 1/23/23.
//

import Foundation
import SpriteKit

class FireBoss: SKSpriteNode, GameObject {
    weak var state: BossState!
    private var attackTimer = 120
    var isGoingUp = true
    var movement = 0
    func setUp(for state: GameState) {
        self.state = state as? BossState
        isHidden = true
    }
    
    func fire() {
        let fireBoss = self
        let miniBoss = MiniBoss()
        miniBoss.enemyType = .fire
        miniBoss.position = fireBoss.position
        scene!.addChild(miniBoss)
        miniBoss.setUp(for: state)

        let move = SKAction.moveTo(x: -640 , duration: 1.5)
        let dash = SKAction.moveTo(y: state.heroPosition.y, duration: 1.5)
        let moveAndDash = SKAction.group([move, dash])
        miniBoss.run(moveAndDash)
    }
    
    func update(_ currentTime: TimeInterval) {
        if state.currentBoss == .bossThree {
            self.isHidden = false
            position.y += CGFloat(movement)
            
            switch state.machine {
            case .attacking:
                fire()
                state.machine = .moving
            case .entering:
                if position.x >= 240 {
                    position.x -= 3
                }
                if position.x <= 240 {
                    state.machine = .moving
                }
            case .moving:
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
                state.machine = .attacking
                attackTimer += 120
            }
        }
    }
    
    func didCollide(with node: SKNode?) {
        if state.machine == .attacking || state.machine == .moving && state.currentBoss == .bossThree  {
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
        state.currentBoss = .bossFour
        state.bossHealthPercentage = 50
        state.machine = .entering
    }
    

}
