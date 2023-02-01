//
//  MiniChomps.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 1/11/23.
//

import Foundation
import SpriteKit

class MiniBoss: SKSpriteNode, GameObject {
    var hp = 0
    weak var state: BossState!
    var enemyType: EnemyType = .chomp
    var dashTimer = 0
    
    func setUp(for state: GameState) {
        self.state = state as? BossState
        self.texture = enemyType.texture()
        self.size = enemyType.size()
        let body = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        
        body.categoryBitMask = 0
        body.contactTestBitMask = 1
        body.collisionBitMask = 0
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        physicsBody = body
        self.isHidden = false
        
        if self.enemyType == .chomp {
            let dashTimer = Int.random(in: 60...180)
            
            self.dashTimer = dashTimer
        } else if enemyType == .worm {
            let dashTimer = 60
            self.dashTimer = dashTimer
        }
        
        if enemyType == .chomp {
            self.hp = 5
        } else if enemyType == .worm {
            self.hp = 50
        } else if enemyType == .fire {
            hp = 50
        }

    }
    
    func update(_ currentTime: TimeInterval) {
        dashTimer -= 1
        if dashTimer <= 0 && enemyType == .chomp {
            let dash = SKAction.moveTo(x: -720, duration: 0.25)
            self.run(dash)
        }
        if dashTimer <= 0 && enemyType == .worm {
            let move = SKAction.moveTo(y: state.heroPosition.y, duration: 1)
            let dash = SKAction.moveTo(x: -720, duration: 1)
            let moveAndDash = SKAction.group([move, dash])
            self.run(moveAndDash)
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
        guard physicsBody != nil else { return }
        physicsBody = nil
        texture = SKTexture(imageNamed: "invisible")
    }
    

    enum EnemyType {
        case eye
        case chomp
        case worm
        case fire
        case sword
        
        
        func texture() -> SKTexture {
            var texture = SKTexture()
            var id = 0
            switch self {
            case .eye:
                id = 0
            case .chomp:
                id = 1
            case .worm:
                id = 4
            case .fire:
                id = 2
            case .sword:
                id = 10
            }
            if id <= 9 {
                texture = SKTexture(imageNamed: "enemy\(id)")
            }
            if id == 10 {
                texture = SKTexture(imageNamed: "s.weapons.sword")
            }
            return texture
        }
     
        func size() -> CGSize {
            switch self {
            case .eye:
                return CGSize(width: 128, height: 128)
            case .chomp:
                return CGSize(width: 190, height: 190)
            case .worm:
                return CGSize(width: 180, height: 180)
            case .fire:
                return CGSize(width: 128, height: 128)
            case .sword:
                return CGSize(width: 128, height: 128)
            }
            
        }
    }

}
