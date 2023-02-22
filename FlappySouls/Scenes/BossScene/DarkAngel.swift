//
//  DarkAngel.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 1/25/23.
//

import Foundation
import SpriteKit

class DarkAngel: SKSpriteNode, GameObject {
    let textures: [SKTexture] = [
        SKTexture(imageNamed: "wing0"),
        SKTexture(imageNamed: "wing1"),
        SKTexture(imageNamed: "wing2"),
        SKTexture(imageNamed: "wing3"),
    ]
    weak var state: BossState!
    private var attackTimer = 900
    var isGoingUp = true
    var movement = 0
    var swordsTimer = 5
    var flapCounter = 0
    var upWings: [SKSpriteNode] = []
    var downWings: [SKNode] = []
    var halo: SKEmitterNode?
    
    func setUp(for state: GameState) {
        guard
            let upZero = childNode(withName: "SKWingUp0") as? SKSpriteNode,
            let upOne = childNode(withName: "SKWingUp1") as? SKSpriteNode,
            let downZero = childNode(withName: "SKWingDown0"),
            let downOne = childNode(withName: "SKWingDown1"),
            let halo = SKEmitterNode(fileNamed: "Halo")
        else { return }
        upWings = [upZero, upOne]
        downWings = [downZero, downOne]
        addChild(halo)
        halo.position = CGPoint(x: 8, y: 56)
        halo.zPosition = 1
        halo.particleBirthRate = 48
        self.halo = halo
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
        if flapCounter < 10 {
            downWings.forEach { $0.isHidden = true }
            for wing in upWings {
                wing.isHidden = false
                wing.texture = textures[0]
            }
        } else if flapCounter < 20 {
            for wing in upWings {
                wing.isHidden = false
                wing.texture = textures[3]
            }
        } else if flapCounter < 23 {
            for wing in upWings {
                wing.isHidden = false
                wing.texture = textures[2]
            }
        } else {
            downWings.forEach { $0.isHidden = false }
            upWings.forEach { $0.isHidden = true }
        }
        flapCounter += 1
        flapCounter %= 35
        
        
        if state.currentBoss == .bossFour {
            self.isHidden = false
            switch state.machine {
                
            case .attacking:
                if attackTimer == 0 {
                    let move = SKAction.moveTo(x: -640, duration: 1)
//                    let rotate = SKAction.rotate(byAngle: CGFloat.pi, duration: 2)
//                    let moveAndRotate = SKAction.group([rotate, move])
                    self.run(move)
                    attackTimer += 900
                    state.machine = .moving
                }
                if attackTimer % 100 == 0 && attackTimer != 0 {
                    fire()
                }
            case .entering:
                if position.x < -500 {
                    position.x = 560
                }
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
                if position.x < -550 {
                    state.machine = .entering
                }
            }
            if attackTimer != 0 {
                attackTimer -= 1
            } else if attackTimer == 0 {
                state.machine = .attacking
                attackTimer += 900
            } else if attackTimer == 450 {
                state.machine = .attacking
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
