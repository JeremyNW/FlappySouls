//
//  Bullet.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/29/22.
//

import Foundation
import SpriteKit

class Bullet: SKSpriteNode, GameObject {
    
    
    func setUp(with controller: GameController) {
        self.zPosition = 0
        texture = SKTexture(imageNamed: "s.shapes.circle.soft")
        self.size = CGSize(width: 25, height: 25)
        
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
