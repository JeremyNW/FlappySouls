//
//  DarkAngel.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 1/25/23.
//

import Foundation
import SpriteKit

class DarkAngel: SKSpriteNode, GameObject {
    weak var state: BossState!
    private var attackTimer = 900
    var isGoingUp = true
    var movement = 0
    var swordsTimer = 5
    
    func setUp(for state: GameState) {
        self.state = state as? BossState
        isHidden = true
    }
    func fire() {
        let DarkAngel = self
        let sword = MiniBoss()
        sword.enemyType = .sword
        sword.position = DarkAngel.position
        scene!.addChild(sword)
        sword.setUp(for: state)

        let move = SKAction.moveTo(x: -640 , duration: 1.5)
        let dash = SKAction.moveTo(y: state.heroPosition.y, duration: 1.5)
        let moveAndDash = SKAction.group([move, dash])
        sword.run(moveAndDash)
    }
    func update(_ currentTime: TimeInterval) {
        if state.currentBoss == .bossFour {
            self.isHidden = false
            switch state.machine {
                
            case .attacking:
                if attackTimer == 0 {
                    let move = SKAction.moveTo(x: -640, duration: 1)
                    let rotate = SKAction.rotate(byAngle: CGFloat.pi, duration: 2)
                    let moveAndRotate = SKAction.group([rotate, move])
                    self.run(moveAndRotate)
                    attackTimer += 900
                    state.machine = .moving
                } else if attackTimer < 450 && attackTimer % 50 == 0 {
                    fire()
                }
            case .entering:
                if position.x >= 240 {
                    position.x -= 3
                }
                if position.x <= 240 {
                    state.machine = .moving
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
            } else if attackTimer == 0 || attackTimer == 450 {
                state.machine = .attacking
                attackTimer += 900
            }
            
        }
        
        
        
        
        if state.bossHealthPercentage < 20 {
            self.color = .angelRed
        }
    }
    
    func didCollide(with node: SKNode?) {
        if state.machine == .attacking || state.machine == .moving && state.currentBoss == .bossFour {
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
        state.currentBoss = .bossFive
        state.bossHealthPercentage = 100
        state.machine = .entering
    }
    
}