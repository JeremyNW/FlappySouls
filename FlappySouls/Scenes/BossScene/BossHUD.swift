//
//  BossHUD.swift
//  FlappySouls
//
//  Created by Paola Warren on 12/22/22.
//

import Foundation
import SpriteKit

class BossHUD: SKNode, GameObject {
    weak var state: BossState!
    var indicators: [SKSpriteNode] = []
    var activeIndicators = -1
    
    func setUp(for state: GameState) {
        self.state = state as? BossState
        for i in 0...6 {
            if let indicator = childNode(withName: "\(i)") as? SKSpriteNode {
                indicators.append(indicator)
            }
        }
    }
    
    func update(_ currentTime: TimeInterval) {
        if state.currentBoss.rawValue > activeIndicators {
            activeIndicators = state.currentBoss.rawValue
            for i in 0...activeIndicators {
                indicators[i].texture = SKTexture(imageNamed: "shield")
                indicators[i].color = .white
            }
        }
    }
    
    func didCollide(with node: SKNode?) {
        
    }
}
