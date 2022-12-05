//
//  Enemy.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/30/22.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode, GameObject {
    var hp = 1.0
    var state: GameState!
    var label: SKLabelNode?

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
        if label == nil {
            let label = SKLabelNode()
            addChild(label)
            self.label = label
            label.xScale = -1
            label.position.x = -64
            label.color = .white
            label.zPosition = 1
        }
    }
    
    func update(_ currentTime: TimeInterval) {
        label?.text = "\(Int(hp.rounded(.up)))"
    }
    
    func didCollide(with body: SKPhysicsBody) {
        hp -= 1
        if hp <= 0 {
            self.isHidden = true
            physicsBody = nil
            state.score += 1
        }
    }
}

private enum EnemyType: Int {
    case weak, normal, strong
    case powerup
    case shield
    case bomb
    
    static func random() -> EnemyType {
        [EnemyType
            .weak, .weak, .weak,
         .normal, .normal, .normal, .normal, .normal,
         .strong, .strong, .strong,
         .powerup,
         .shield,
         .bomb
        ].randomElement() ?? .normal
    }
    
    func hitpoints(state: GameState) -> Double {
        let score = Double(state.score)
        let hp = Double.random(in: (score * 0.9)...(score * 1.1))
        switch self {
        case .weak:
            return hp * 0.8
        case .normal:
            return hp
        case .strong:
            return hp * 1.2
        case .powerup:
            return hp
        case .shield:
            return hp
        case .bomb:
            return hp
        }
    }
    
    func texture() -> SKTexture {
        SKTexture(imageNamed: "enemy\(rawValue)")
        //    switch self {
        //    case .weak:
        //      <#code#>
        //    case .normal:
        //      <#code#>
        //    case .strong:
        //      <#code#>
        //    case .powerup:
        //      <#code#>
        //    case .shield:
        //      <#code#>
        //    case .bomb:
        //      <#code#>
        //    }
    }
    
}
