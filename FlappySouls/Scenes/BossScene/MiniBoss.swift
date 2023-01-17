//
//  MiniChomps.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 1/11/23.
//

import Foundation
import SpriteKit

class MiniBoss: SKSpriteNode, GameObject {
    var hp = 1
    weak var state: BossState!
    var enemyType: EnemyType = .chomp
    
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
        self.position.x = 0
        self.position.y = 0
        
    }
    
    func update(_ currentTime: TimeInterval) {
        
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
        
        
        func texture() -> SKTexture {
            var id = 0
            switch self {
            case .eye:
                id = 0
            case .chomp:
                id = 1
            case .worm:
                id = 4
            case .fire:
                id = 5
            }
            return SKTexture(imageNamed: "enemy\(id)")
        }
     
        func size() -> CGSize {
            switch self {
            case .eye:
                return CGSize(width: 128, height: 128)
            case .chomp:
                return CGSize(width: 175, height: 175)
            case .worm:
                return CGSize(width: 128, height: 128)
            case .fire:
                return CGSize(width: 128, height: 128)
            }
            
        }
    }

}
