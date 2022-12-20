//
//  PowerUp.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 12/16/22.
//

import Foundation
import SpriteKit

class PowerUp: SKSpriteNode, GameObject {
    
    var state: GameState!
    let type = PowerUpType.allCases.randomElement()!

    func setUp(for state: GameState) {
        self.state = state
        self.texture = type.texture()
        self.position = CGPoint(x: 850, y: Int.random(in: -550...550))
        self.size = CGSize(width: 64, height: 64)
        
        let body = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        body.categoryBitMask = 0
        body.contactTestBitMask = 1
        body.collisionBitMask = 0
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        physicsBody = body
    }
    
    func update(_ currentTime: TimeInterval) {
        self.position.x -= 5
    }
    
    func didCollide(with node: SKNode?) {
        type.onDeath(state: state)
        self.removeFromParent()
    }
    
    
    
    enum PowerUpType: CaseIterable {
        case sword
        case shield
        
        func onDeath(state: GameState) {
            switch self {
            case .sword:
                state.swords += 10
            case .shield:
                state.isShielded = true
            }
            
        }
        
        func texture() -> SKTexture {
            switch self {
            case .shield:
                return SKTexture(imageNamed: "shield")
            case .sword:
                return SKTexture(imageNamed: "s.weapons.sword")
            }
        }
        
        
    }
    
}
