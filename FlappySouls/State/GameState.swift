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
            increaseXP(by: 0.1)
        }
    }
    var waves = 0 {
        didSet {
            increaseXP(by: 0.1)
        }
    }
    var isShielded = false
    var swords = 0
    var power: Int { Int(xp) }
    var powerupCooldown = 0
    var isDead = false
    private var xp = 1.0

    func increaseXP(by amount: Double = 1) {
        xp += amount
    }
    
    func update(_ currentTime: TimeInterval) {
        powerupCooldown -= 1
    }
    
    func tearDown() {
        var highscore = UserDefaults.standard.integer(forKey: "highscore")
        if score > highscore {
            highscore = score
        }
    }
}
