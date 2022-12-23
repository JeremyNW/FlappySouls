//
//  BossState.swift
//  FlappySouls
//
//  Created by Paola Warren on 12/22/22.
//

import Foundation

class BossState: GameState, AngelDataSource, BulletDataSource {
    var isDead = false
    var slainWithShield = 0
    var attackedWithSword = 0
    var isShielded = false
    var swords = 0
    var powerupSpawnTimer = 60
    var heroPosition = CGPoint.zero
    var power = 0
  var bossHealthPercentage = 0
    
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
