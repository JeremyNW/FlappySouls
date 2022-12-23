//
//  GameState.swift
//  FlappySouls
//
//  Created by Jared Warren on 11/28/22.
//

import Foundation
import SpriteKit

class GameState {
    weak private(set) var scene: SKScene?
    
    required init(scene: SKScene) {
        self.scene = scene
    }

    func update(_ currentTime: TimeInterval) {}
    func tearDown() {}
}
