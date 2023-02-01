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
    var movement = 5
    var YPosition = CGFloat(300)
    func setUp(for state: GameState) {
        self.state = state as? BossState
        isHidden = true
        self.zPosition = 0
    }
    
    func positionWorms() {
        let wormBoss = self
        let worms: [MiniBoss] = [
        MiniBoss(),
        MiniBoss()
        ]
        for worm in worms {
            scene!.addChild(worm)
            worm.enemyType = .worm
            worm.setUp(for: state)
            worm.position = wormBoss.position
            let position = SKAction.moveTo(y: YPosition, duration: 1)
            worm.run(position)
            YPosition -= 600
        }
        YPosition = 300
    }

    
    func update(_ currentTime: TimeInterval) {
        if state.currentBoss == .bossTwo {
            
            switch state.machine {
                
            case .attacking:
                positionWorms()
                state.machine = .moving
            case .entering:
                if position.x > 240 {
                    position.x -= 3
                }
                if position.x <= 240 {
                    state.machine = .moving
                }
                
            case .moving:
                break
            }
            
            if state.currentBoss == .bossTwo {
                self.isHidden = false
                
                if attackTimer != 0 {
                    attackTimer -= 1
                } else {
                    state.machine = .attacking
                    attackTimer += 420
                }
                
                
                if state.bossHealthPercentage < 20 {
                    self.color = .angelRed
                }
            }
        }
    }
    func didCollide(with node: SKNode?) {
        if state.machine == .attacking || state.machine == .moving && state.currentBoss == .bossTwo {
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
        state.currentBoss = .bossThree
        state.bossHealthPercentage = 1
        state.machine = .entering
    }
}
