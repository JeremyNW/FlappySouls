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
        
    }
    
    func update(_ currentTime: TimeInterval) {

        position.x -= 6
    }
    
    func didCollide(with body: SKPhysicsBody) {
        
    }
    
}
