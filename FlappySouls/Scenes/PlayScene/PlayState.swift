//
//  PlayState.swift
//  FlappySouls
//
//  Created by Paola Warren on 12/22/22.
//

import Foundation
import SpriteKit
import GameKit

class PlayState: GameState, AngelDataSource, HUDDataSource, PauseDataSource, BulletDataSource {
    var isPaused = false
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
    var isDead = false
    var isShielded = false
    var swords = 0
    var power: Int { Int(xp) }
    var powerupCooldown = 0
    var heroPosition: CGPoint = .zero
    var attackedWithSword = 0
    var slainEyes = 0
    var slainTeeth = 0
    var slainArmor = 0
    var slainWithShield = 0
    
    private var xp = 1.0
    
    func increaseXP(by amount: Double = 1) {
        xp += amount
    }
    
    override func update(_ currentTime: TimeInterval) {
        powerupCooldown -= 1
    }
    
    
    override func tearDown() {
        let persistence = Persistence.shared
        persistence.incrementInteger(.attackedWithSword, additionalValue: attackedWithSword)
        persistence.incrementInteger(.slainEyes, additionalValue: slainEyes)
        persistence.incrementInteger(.slainTeeth, additionalValue: slainTeeth)
        persistence.incrementInteger(.slainArmor, additionalValue: slainArmor)
        persistence.incrementInteger(.slainWithShield, additionalValue: slainWithShield)
        
        Leaderboards.shared.report(score)
        Achievements.shared.report(
            score: score,
            waves: waves,
            baseDamage: power,
            isFallen: swords > 0 && isShielded
        )
    }
}
