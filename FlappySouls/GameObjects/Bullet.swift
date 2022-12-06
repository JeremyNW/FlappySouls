//
//  Bullet.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/29/22.
//

import Foundation
import SpriteKit

class Bullet: SKSpriteNode, GameObject {
    var state: GameState!
    var damage: Int = 1
    
    func setUp(for state: GameState) {
        self.state = state
        
        let type = BulletType.getType(for: state)
        damage = type.damage(for: state)
        size = type.size()
        texture = type.texture()
        color = type.color()
        zRotation = type.rotation()
        zPosition = 0
        colorBlendFactor = 1
        
        let body = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        body.categoryBitMask = 1
        body.contactTestBitMask = 0
        body.collisionBitMask = 0
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        physicsBody = body
    }
    
    func update(_ currentTime: TimeInterval) {
        self.position.x += 8
        if self.position.x > 375 {
            self.removeFromParent()
        }
        
    }
    
    func didCollide(with node: SKNode?) {
        self.removeFromParent()
    }
    
    
}

enum BulletType {
    case standard
    case sword
    
    static func getType(for state: GameState) -> BulletType {
        if state.swords > 0 {
            state.swords -= 1
            return.sword
        }
        return .standard
    }
    
    func texture() -> SKTexture {
        switch self {
        case .standard:
            return SKTexture(imageNamed: "s.shapes.circle.soft")
        case .sword:
            return SKTexture(imageNamed: "s.weapons.sword")
        }
    }
    
    func size() -> CGSize {
        switch self {
        case .standard:
            return CGSize(width: 16, height: 16)
        case .sword:
            return CGSize(width: 64, height: 64)
        }
    }
    
    func damage(for state: GameState) -> Int {
        switch self {
        case .standard:
            return state.power
        case .sword:
            return state.power * 2
        }
    }
    
    func color() -> UIColor {
        switch self {
        case .standard:
            return UIColor(red: 0.8, green: 1, blue: 1, alpha: 1)
        case .sword:
            return .white
        }
    }
    
    func rotation() -> CGFloat {
        switch self {
        case .standard:
            return 0
        case .sword:
            return -0.5 * .pi
        }
    }
}
