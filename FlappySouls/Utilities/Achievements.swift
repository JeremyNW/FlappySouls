//
//  Achievements.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/11/22.
//

import Foundation
import GameKit

class Achievements {
  static let shared = Achievements()
  let baseDamage = 50
  
  // required per/percentage point
  let attackedWithSword: Double = 100
  let slainEnemy: Double = 10
  let slainWithShield: Double = 1
  
  private init() {}
  
  func report(_ baseDamage: Int) {
    let persistence = Persistence.shared
   
    var achievements: [GKAchievement] = []
    
    let eye = GKAchievement(identifier: "eye")
    eye.percentComplete = Double(persistence.getInteger(.slainEyes)) / slainEnemy
    achievements.append(eye)
    
    let tooth = GKAchievement(identifier: "tooth")
    tooth.percentComplete = Double(persistence.getInteger(.slainTeeth)) / slainEnemy
    achievements.append(tooth)
    
    let armor = GKAchievement(identifier: "armor")
    armor.percentComplete = Double(persistence.getInteger(.slainArmor)) / slainEnemy
    achievements.append(armor)
    
    let shield = GKAchievement(identifier: "shield")
    shield.percentComplete = Double(persistence.getInteger(.slainWithShield)) / slainWithShield
    achievements.append(shield)
    
    let sword = GKAchievement(identifier: "sword")
    sword.percentComplete = Double(persistence.getInteger(.attackedWithSword)) / attackedWithSword
    achievements.append(sword)
    
    if baseDamage >= self.baseDamage {
      let seed = GKAchievement(identifier: "seed")
      seed.percentComplete = 100
      achievements.append(seed)
    }
    
    achievements.forEach { $0.showsCompletionBanner = true }
    
    GKAchievement.report(achievements)
  }
  
  enum Achievement {
    case attackedWithSword
    case slainEyes
    case slainTeeth
    case slainArmor
    case slainWithShield
  }
}
