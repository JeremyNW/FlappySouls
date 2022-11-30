//
//  Enemy.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/30/22.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode, GameObject {
    
    var hitPoints: Int = 10
    
    func setUp(with controller: GameController) {
        
    }
    
    func update(_ currentTime: TimeInterval) {
      
    }
    
    func didCollide(with body: SKPhysicsBody) {
        hitPoints -= 1
        if hitPoints == 0 {
            self.removeFromParent()
        }
    }
    
    
}
