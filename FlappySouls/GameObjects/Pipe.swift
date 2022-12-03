//
//  Pipe.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/27/22.
//

import Foundation
import SpriteKit

class Pipe: SKNode, GameObject {
    
    var controller: GameController?
    
    func setUp(with controller: GameController) {
        self.controller = controller
        setUpChildren()
    }
    
    func update(_ currentTime: TimeInterval) {
        
        position.x -= 4
        if position.x < -512 {
            controller?.waves += 1
            position.x = 1024
            setUpChildren()
        }
    }
    
    func didCollide(with body: SKPhysicsBody) {
        
    }
    
    func setUpChildren() {
        guard let controller = controller else { return }
        for child in children {
            if let child = child as? GameObject {
                child.setUp(with: controller)
            }
        }
    }
}
