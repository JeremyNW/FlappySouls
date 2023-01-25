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

enum BossStateMachine {
    case attacking, entering, moving
}

enum miniBossStateMachine {
    case attacking, moving
}


class BossState: GameState {
    var attackedWithSword = 0
    var bossHealthPercentage = 100
    var currentBoss: BossType = .eye
    var heroPosition: CGPoint = .zero
    var power = 1
    var isDead = false
    var isPaused = false
    var isShielded = false
    var isAttacking = false
    var slainWithShield = 0
    var swords = 0
    var machine: BossStateMachine = .entering
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
    func nextBoss() {
        currentBoss = BossType(rawValue: currentBoss.rawValue + 1) ?? .eye

    }
    
    
}

extension BossState: AngelDataSource,
                     BulletDataSource,
                     DeathMenuDataSource,
                     PauseMenuDataSource {}
