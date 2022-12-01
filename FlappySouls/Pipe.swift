//
//  Pipe.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/27/22.
//

import Foundation
import SpriteKit

class Pipe: SKNode, GameObject {
    
    func setUp(with controller: GameController) {
        
        
        for child in children {
            if let child = child as? GameObject {
                child.setUp(with: controller)
            }
        }
    }
    
    func update(_ currentTime: TimeInterval) {

        position.x -= 6
        if position.x < -380 {
            position.x = 420
        }
    }
    
    func didCollide(with body: SKPhysicsBody) {
        
    }
    
}
