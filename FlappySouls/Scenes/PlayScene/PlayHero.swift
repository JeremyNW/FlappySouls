//
//  PlayHero.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/27/22.
//

import Foundation
import SpriteKit

class PlayHero: Hero {
    weak var state: PlayState!
    
    override func setUp(for state: GameState) {
        super.setUp(for: state)
        self.state = state as? PlayState
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
    override func didCollide(with node: SKNode?) {
        super.didCollide(with: node)
    }
}
