//
//  WormBoss.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 1/10/23.
//

import Foundation
import SpriteKit

class WormBoss: SKSpriteNode, GameObject {
    weak var state: BossState!
    private var attackTimer = 420
    var miniBoss1 = MiniBoss()
    var miniBoss2 = MiniBoss()
  
    var movement = 5
    func setUp(for state: GameState) {
        self.state = state as? BossState
        isHidden = true
        self.addChild(miniBoss1)
        self.addChild(miniBoss2)
        miniBoss1.physicsBody?.pinned = false
        miniBoss2.physicsBody?.pinned = false
    }
    let middle = SKAction.moveTo(x: 0, duration: 1)
    let center = SKAction.moveTo(y: 0, duration: 1)
    let shoot = SKAction.moveTo(x: -640, duration: 1)
    let top = SKAction.moveTo(y: 320, duration: 1)
    let bottom = SKAction.moveTo(y: -320, duration: 1)
    
    func topAttack() {

        miniBoss1.enemyType = .worm
        miniBoss2.enemyType = .worm
        miniBoss1.setUp(for: state)
        miniBoss2.setUp(for: state)
        miniBoss1.position.x = self.position.x
        miniBoss2.position.x = self.position.x
        miniBoss1.position.y = 0
        miniBoss2.position.y = -250
        miniBoss1.run(shoot)
        let moveCenter = SKAction.group([center, middle])
        let shootDown = SKAction.group([shoot, bottom])
        let attack = SKAction.sequence([moveCenter, shootDown])
        miniBoss2.run(attack)
    }
    func middleAttack() {
        miniBoss1.enemyType = .worm
        miniBoss2.enemyType = .worm
        miniBoss1.setUp(for: state)
        miniBoss2.setUp(for: state)
        miniBoss1.position.x = self.position.x
        miniBoss2.position.x = self.position.x
        miniBoss1.position.y = 0
        miniBoss2.position.y = -250
        let moveCenter = SKAction.group([center, middle])
        let shootDown = SKAction.group([shoot, bottom])
        let shootUp = SKAction.group([shoot, top])
        let attackDown = SKAction.sequence([moveCenter, shootDown])
        let attackUp = SKAction.sequence([moveCenter, shootUp])
        miniBoss1.run(attackUp)
        miniBoss2.run(attackDown)
    }
    func bottomAttack() {
        miniBoss1.enemyType = .worm
        miniBoss2.enemyType = .worm
        miniBoss1.setUp(for: state)
        miniBoss2.setUp(for: state)
        miniBoss1.position.x = self.position.x
        miniBoss2.position.x = self.position.x
        miniBoss1.position.y = 250
        miniBoss2.position.y = 0
        let moveCenter = SKAction.group([center, middle])
        let shootDown = SKAction.group([shoot, bottom])
        let shootUp = SKAction.group([shoot, top])
        let attackDown = SKAction.sequence([moveCenter, shootDown])
        let attackUp = SKAction.sequence([moveCenter, shootUp])
        miniBoss1.run(attackDown)
        miniBoss2.run(attackUp)
    }
    
    func miniWormAttack() {
        let miniBosses: [MiniBoss] = [
        MiniBoss(),
        MiniBoss(),
        MiniBoss()
        ]
    }
    
    func update(_ currentTime: TimeInterval) {
        if state.currentBoss == .bossTwo {
            
            switch state.stateMachine {
                
            case .attacking:
                movement = 0
                if position.y >= 250 {
                    topAttack()
                    state.stateMachine = .moving
                } else if position.y <= -250 {
                    bottomAttack()
                    state.stateMachine = .moving
                } else {
                    middleAttack()
                    state.stateMachine = .moving
                }
            case .entering:
                if position.x > 240 {
                    position.x -= 3
                }
                if position.x <= 240 {
                    state.stateMachine = .moving
                }
                
            case .moving:
                break
            }
            
            if state.currentBoss == .bossTwo {
                self.isHidden = false
                
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
        state.currentBoss = .bossThree
        state.bossHealthPercentage = 100
    }
}
