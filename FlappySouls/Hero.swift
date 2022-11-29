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
    var upWing: SKNode?
    var flapWing: SKNode?
    
    func setUp(with controller: GameController) {
        upWing = childNode(withName: "SKWingUp")
        flapWing = childNode(withName: "SKWingDown")
        flapWing?.isHidden = true
    }
    
    func update(_ currentTime: TimeInterval) {
     
        position.y += yVelocity
        yVelocity -= 0.25
        if position.y < -600 {
            yVelocity = 0
        }
        if position.y > 620 {
            yVelocity = 0
            position.y = 620
        }
        
        if yVelocity < 2.5 {
            flapWing?.isHidden = true
            upWing?.isHidden = false
        } else {
            flapWing?.isHidden = false
            upWing?.isHidden = true
        }
    }
    
    func didCollide(with body: SKPhysicsBody) {
        print("Game Over")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        yVelocity = 10
        
    }
}
