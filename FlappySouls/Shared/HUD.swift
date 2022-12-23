//
//  HUD.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/30/22.
//

import Foundation
import SpriteKit

protocol HUDDataSource: AnyObject {
    var power: Int { get }
    var score: Int { get }
    var swords: Int { get }
    var powerupCooldown: Int { get }
}

class HUD: SKNode, GameObject {
    
    weak var dataSource: HUDDataSource!
    var scoreLabel: SKLabelNode?
    var damageLabel: SKLabelNode?
    
    func setUp(for state: GameState) {
        self.dataSource = state as? HUDDataSource
        scoreLabel = childNode(withName: "Score") as? SKLabelNode
        damageLabel = childNode(withName: "Damage") as? SKLabelNode
    }
    
    func update(_ currentTime: TimeInterval) {
        scoreLabel?.text = "Souls: \(dataSource.score)"
        damageLabel?.text = "Damage: \(dataSource.swords > 0 ? dataSource.power * 2 : dataSource.power)"
        damageLabel?.fontColor = dataSource.swords > 0 ? .angelRed :
        dataSource.powerupCooldown > 0 ? .angelGreen : .white
    }
    
    func didCollide(with node: SKNode?) {}
}
