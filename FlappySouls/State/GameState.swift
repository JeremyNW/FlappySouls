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
    private let haptics = HapticFeedbackGenerators()
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
        GKLeaderboard
          .submitScore(
          score,
          context: 0,
          player: GKLocalPlayer.local,
          leaderboardIDs: ["Eternal", "Ephemeral"]) { error in
            if let error {
              print(error, error.localizedDescription)
            }
          }
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
