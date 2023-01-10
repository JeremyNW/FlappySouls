//
//  BossState.swift
//  FlappySouls
//
//  Created by Paola Warren on 12/22/22.
//

import Foundation

enum BossType: Int {
    case eye // bossZero
    case bossOne
    case bossTwo
    case bossThree
    case bossFour
    case bossFive
    case bossSix
}


class BossState: GameState {
    var attackedWithSword = 0
    var bossHealthPercentage = 100
    // Boss Health Percentage = 100 because when we * 6 in HealthBar.swift it will equal the width of the SKSpriteNode
    var currentBoss: BossType = .eye
    var heroPosition = CGPoint.zero
    var power = 1
    var isDead = false
    var isPaused = false
    var isShielded = false
    var powerupSpawnTimer = 60
    var slainWithShield = 0
    var swords = 0
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        powerupSpawnTimer -= 1
        if powerupSpawnTimer <= 0 {
            let powerUp = PowerUp()
            self.scene?.addChild(powerUp)
            powerUp.setUp(for: self)
            powerupSpawnTimer = 60
        }
    }
}

extension BossState: AngelDataSource,
                     BulletDataSource,
                     DeathMenuDataSource,
                     PauseMenuDataSource {}
