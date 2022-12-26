//
//  HealthBar.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 12/21/22.
//

import Foundation
import SpriteKit

class HealthBar: SKNode, GameObject {

    var currentHealthBar: SKSpriteNode?
    var maxHealthBar: SKSpriteNode?
    var state: BossState!
    
    func setUp(for state: GameState) {
        self.state = state as? BossState
        currentHealthBar = childNode(withName: "currentHealth") as? SKSpriteNode
        maxHealthBar = childNode(withName: "maxHealth") as? SKSpriteNode
        
    }
    
    func update(_ currentTime: TimeInterval) {
        currentHealthBar?.size.width = CGFloat(state.bossHealthPercentage * 6)
        currentHealthBar?.position.x = CGFloat(state.bossHealthPercentage - 6)
    }
    
    func didCollide(with node: SKNode?) {
        
    }
    
    
}
