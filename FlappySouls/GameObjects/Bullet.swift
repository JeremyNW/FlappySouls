//
//  Bullet.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/29/22.
//

import Foundation
import SpriteKit

class Bullet: SKSpriteNode, GameObject {
    
    func setUp(for state: GameState) {
        self.zPosition = 0
        texture = SKTexture(imageNamed: "s.shapes.circle.soft")
        self.size = CGSize(width: 26, height: 26)
        let body = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        body.categoryBitMask = 1
        body.contactTestBitMask = 0
        body.collisionBitMask = 0
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        self.physicsBody = body
    }
    
    func update(_ currentTime: TimeInterval) {
        self.position.x += 8
        if self.position.x > 375 {
            self.removeFromParent()
        }
        
    }
    
    func didCollide(with body: SKPhysicsBody) {
        self.removeFromParent()
    }
    
    
}
