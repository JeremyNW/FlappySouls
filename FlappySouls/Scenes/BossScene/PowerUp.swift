//
//  PowerUp.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 12/16/22.
//

import Foundation
import SpriteKit

class PowerUp: SKSpriteNode, GameObject {
    
    var state: GameState!
    let type = PowerUpType.allCases.randomElement()!
    
    func setUp(for state: GameState) {
        self.state = state
        self.texture = type.texture()
    }
    
    func update(_ currentTime: TimeInterval) {
        
    }
    
    func didCollide(with node: SKNode?) {
        type.onDeath(state: state)
        self.removeFromParent()
    }
    
    
    
    enum PowerUpType: CaseIterable {
        case sword
        case shield
        
        func onDeath(state: GameState) {
            switch self {
            case .sword:
                state.swords += 10
            case .shield:
                state.isShielded = true
            }
            
        }
        
        func texture() -> SKTexture {
            switch self {
            case .shield:
                return SKTexture(imageNamed: "shield")
            case .sword:
                return SKTexture(imageNamed: "s.weapons.sword")
            }
        }
        
        
    }
    
}
