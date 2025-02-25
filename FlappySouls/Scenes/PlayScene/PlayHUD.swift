//
//  PlayHUD.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/30/22.
//

import Foundation
import SpriteKit

class PlayHUD: SKNode, GameObject {
    
    weak var state: PlayState!
    var scoreLabel: SKLabelNode?
    var damageLabel: SKLabelNode?
    
    func setUp(for state: GameState) {
        self.state = state as? PlayState
        scoreLabel = childNode(withName: "Score") as? SKLabelNode
        damageLabel = childNode(withName: "Damage") as? SKLabelNode
    }
    
    func update(_ currentTime: TimeInterval) {
        scoreLabel?.text = "Souls: \(state.score)"
        damageLabel?.text = "Damage: \(state.swords > 0 ? state.power * 2 : state.power)"
        damageLabel?.fontColor = state.swords > 0 ? .angelRed :
        state.powerupCooldown > 0 ? .angelGreen : .white
    }
    
    func didCollide(with node: SKNode?) {}
}
