//
//  Pipe.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/27/22.
//

import Foundation
import SpriteKit

class Pipe: SKNode, GameObject {
    
    var state: GameState?
    
    func setUp(for state: GameState) {
        self.state = state
        setUpChildren()
    }
    
    func update(_ currentTime: TimeInterval) {
        position.x -= 4
        if position.x < -800 {
            state?.waves += 1
            position.x = 1600
            setUpChildren()
        }
    }
    
    func didCollide(with node: SKNode?) {
        
    }
    
    func setUpChildren() {
        guard let state else { return }
        for child in children {
            if let child = child as? GameObject {
                child.setUp(for: state)
            }
        }
    }
}
