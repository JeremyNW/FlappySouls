//
//  Enemy.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/30/22.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode, GameObject {
    var hp = 1
    var state: GameState!
    var label: SKLabelNode?
    fileprivate var type: EnemyType = .normal
    
    func setUp(for state: GameState) {
        self.state = state
        let body = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        body.categoryBitMask = 0
        body.contactTestBitMask = 1
        body.collisionBitMask = 0
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        self.physicsBody = body
        self.isHidden = false
        let type = EnemyType.random()
        texture = type.texture()
        hp = type.hitpoints(state: state)
        color = type.color()
        colorBlendFactor = 1
        if label == nil {
            let label = SKLabelNode()
            addChild(label)
            self.label = label
            label.xScale = -1
            label.position.x = -64
            label.zPosition = 1
            label.fontColor = .white
            label.fontName = "HelveticaNeue-CondensedBlack"
        }
        self.type = type
    }
    
    func update(_ currentTime: TimeInterval) {
        label?.text = "\(hp)"
    }
    
    func didCollide(with node: SKNode?) {
        if node is Hero {
            hp = 0
        } else if let node = node as? Bullet {
            hp -= node.damage
        } else {
            print("This enemy collided with a bullet that has already been destroyed.")
            hp -= state.power
        }
        if hp <= 0 {
            self.isHidden = true
            physicsBody = nil
            state.score += 1
            type.onDeath(for: state)
        }
    }
}

private enum EnemyType {
    case weak, normal, strong
    case powerup
    case shield
    case bomb
    
    static func random() -> EnemyType {
        [EnemyType
            .weak, .weak, .weak, .weak, .weak,
         .normal, .normal, .normal, .normal, .normal,
         .strong, .strong, .strong, .strong, .strong,
         .powerup,
         .shield,
         .bomb,
        ].randomElement() ?? .normal
    }
    
    func hitpoints(state: GameState) -> Int {
        let score = Double(state.score)
        var hp = Double.random(in: (score * 0.6)...(score * 1.2))
        switch self {
        case .weak:
            hp *= 0.6
        case .normal:
            hp += 0.1 * Double(state.waves * state.waves)
        case .strong:
            hp += Double(state.waves * state.waves)
        case .powerup:
            break
        case .shield:
            break
        case .bomb:
            break
        }
        return Int(hp) + Int.random(in: 1...3)
    }
    
    func texture() -> SKTexture {
        var id = 0
        switch self {
        case .weak:
            id = 0
        case .normal:
            id = 1
        case .strong:
            id = 4
        case .powerup:
            id = 5
        case .shield:
            id = 3
        case .bomb:
            id = 2
        }
        return SKTexture(imageNamed: "enemy\(id)")
    }
    
    func color() -> UIColor {
        switch self {
        case .weak:
            return .white
        case .normal:
            return .white
        case .strong:
            return .white
        case .powerup:
            return .angelGreen
        case .shield:
            return .cyan
        case .bomb:
            return .enemyRed
        }
    }
    
    func onDeath(for state: GameState) {
        switch self {
        case .weak, .normal, .strong:
            break
        case .powerup:
            state.increaseXP()
            state.powerupCooldown = 90
            state.sendHapticFeedback(.rigid)
        case .shield:
            state.isShielded = true
            state.sendHapticFeedback(.soft)
        case .bomb:
            state.swords += 24
            state.sendHapticFeedback(.rigid)
        }
    }
}
