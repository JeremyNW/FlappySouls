//
//  HealthBar.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 12/21/22.
//

import Foundation
import SpriteKit

class HealthBar: SKNode, GameObject {
    
    var currentHealthBar: SKSpriteNode!
    var maxHealthBar: SKSpriteNode!
    var state: GameState!
    
    func setUp(for state: GameState) {
        self.state = state
        self.currentHealthBar.size.width = CGFloat(state.bossHealthPercentage * 6)
    }
    
    func update(_ currentTime: TimeInterval) {
    }
    
    func didCollide(with node: SKNode?) {
        
    }
    
    
}
