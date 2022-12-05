//
//  Score.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/30/22.
//

import Foundation
import SpriteKit

class Score: SKNode, GameObject {
    
    var state: GameState!
    var label: SKLabelNode?
    
    func setUp(for state: GameState) {
        self.state = state
        self.label = children.first as? SKLabelNode
    }
    
    func update(_ currentTime: TimeInterval) {
        label?.text = "\(state?.score ?? 0)"
    }
    
    func didCollide(with body: SKPhysicsBody) {
        
    }
    
    
}