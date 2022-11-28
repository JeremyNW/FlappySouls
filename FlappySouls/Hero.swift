//
//  Hero.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/27/22.
//

import Foundation
import SpriteKit

class Hero: SKSpriteNode, GameObject {
    
    var yVelocity = CGFloat(0)
    
    func setUp() {
        
    }
    
    func update(_ currentTime: TimeInterval) {
     
        position.y += yVelocity
        yVelocity -= 0.25
        
        
    }
    
    func didCollide(with body: SKPhysicsBody) {
        print("Game Over")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        yVelocity = 10
    }
}
