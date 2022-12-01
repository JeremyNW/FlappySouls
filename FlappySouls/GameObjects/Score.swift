//
//  Score.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/30/22.
//

import Foundation
import SpriteKit

class Score: SKNode, GameObject {
    
    var controller: GameController!
    var label: SKLabelNode?
    
    func setUp(with controller: GameController) {
        self.controller = controller
        self.label = children.first as? SKLabelNode
    }
    
    func update(_ currentTime: TimeInterval) {
        label?.text = "\(controller?.score ?? 0)"
        print(controller?.score ?? 0)
    }
    
    func didCollide(with body: SKPhysicsBody) {
        
    }
    
    
}
