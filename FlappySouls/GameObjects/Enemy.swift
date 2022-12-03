//
//  Enemy.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/30/22.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode, GameObject {
    var hitPoints: Int = 2
    var controller: GameController!
    func setUp(with controller: GameController) {
        self.controller = controller
        let body = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        body.categoryBitMask = 0
        body.contactTestBitMask = 1
        body.collisionBitMask = 0
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        self.physicsBody = body
        self.isHidden = false
        hitPoints = 2
        texture = SKTexture(imageNamed: "enemy\(controller.score % 7)")
    }
    
    func update(_ currentTime: TimeInterval) {
      
    }
    
    func didCollide(with body: SKPhysicsBody) {
        hitPoints -= 1
        if hitPoints <= 0 {
            self.isHidden = true
            physicsBody = nil
            controller.score += 1
        }
    }
    
    
}
