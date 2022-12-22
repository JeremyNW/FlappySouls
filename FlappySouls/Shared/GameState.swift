//
//  GameState.swift
//  FlappySouls
//
//  Created by Jared Warren on 11/28/22.
//

import Foundation
import UIKit
import GameKit

class GameState {
    static var isFullscreen = false
    private let haptics = HapticFeedbackGenerators()
    weak var scene: SKScene!
    
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
    var powerUpTimer = 900
    var isBossMode = false
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
    var bossHealthPercentage = 100
    
    private var xp = 1.0

    func increaseXP(by amount: Double = 1) {
        xp += amount
    }
    
    func update(_ currentTime: TimeInterval) {
        
        
        if isBossMode {
            powerUpTimer -= 1
            if powerUpTimer <= 0 {
                let powerUp = PowerUp()
                self.scene.addChild(powerUp)
                powerUp.setUp(for: self)
                powerUpTimer = 900
              
               
            }
        } else {
            powerupCooldown -= 1
        }
            
         
        }
    
    
    func tearDown() {
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
    
    func sendHapticFeedback(_ type: HapticType) {
        switch type {
        case .soft:
            haptics.soft.impactOccurred(intensity: 1)
        case .heavy:
            haptics.heavy.impactOccurred(intensity: 1)
        case .rigid:
            haptics.rigid.impactOccurred(intensity: 1)
        }
    }
    
    enum HapticType {
        case soft, heavy, rigid
    }
    
}

private class HapticFeedbackGenerators {
    let soft: UIImpactFeedbackGenerator = {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.prepare()
        return generator
    }()
    let heavy: UIImpactFeedbackGenerator = {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        return generator
    }()
    let rigid: UIImpactFeedbackGenerator = {
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.prepare()
        return generator
    }()
}
