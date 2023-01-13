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
  
    var MBPositionX: CGFloat = 500
    var MBPositionY: CGFloat = 0
    
    func miniChompAttack() {
        var miniBosses: [MiniBoss] = [
        MiniBoss(),
        MiniBoss(),
        MiniBoss(),
        MiniBoss(),
        MiniBoss()
            ]
        for miniBoss in miniBosses {
            scene?.addChild(miniBoss)
            miniBoss.enemyType = .chomp
            miniBoss.setUp(for: state)
            let move = SKAction.moveTo(y: MBPositionY, duration: 1.5)
            miniBoss.run(move)
            MBPositionY -= 80
        }
    }
    
    func setUp(for state: GameState) {
        self.state = state as? BossState
        isHidden = true
    }
    
    func update(_ currentTime: TimeInterval) {
        if state.currentBoss == .bossOne {
            self.isHidden = false
            
            if attackTimer != 0 {
                attackTimer -= 1
            } else {
               miniChompAttack()
                attackTimer += 420
            }
            
            
            if position.x > 240 {
                position.x -= 3
            }
            if state.bossHealthPercentage < 20 {
                self.color = .angelRed
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
        state.currentBoss = .bossTwo
        state.bossHealthPercentage = 100
    }
}
