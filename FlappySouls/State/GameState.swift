//
//  GameState.swift
//  FlappySouls
//
//  Created by Jared Warren on 11/28/22.
//

import Foundation

class GameState {
    var score = 0 {
        didSet {
            currency += 1
            increaseXP(by: 0.1)
        }
    }
    var waves = 0 {
        didSet {
            currency += 1
            increaseXP(by: 0.1)
        }
    }
    private(set) var currency = 0
    var isShielded = false
    var swords = 0
    private var xp = 1.0
    var power: Int { Int(xp) }
    func increaseXP(by amount: Double = 1) {
        xp += amount
    }
    var powerupCooldown = 0
    
    func update(_ currentTime: TimeInterval) {
        powerupCooldown -= 1
    }
}
