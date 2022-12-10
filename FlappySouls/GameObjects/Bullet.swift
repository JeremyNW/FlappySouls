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
    var isDead = false
    var particles: SKEmitterNode?
    
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
        let name = type == .sword ? "sword" : "bullet"
        run(.playSoundFileNamed(name + "\(Int.random(in: 0...4)).wav", waitForCompletion: false))
        
        let body = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        body.categoryBitMask = 1
        body.contactTestBitMask = 0
        body.collisionBitMask = 0
        body.affectedByGravity = false
        body.allowsRotation = false
        body.pinned = false
        body.isDynamic = true
        physicsBody = body
        
        guard let particles = type.particles() else { return }
        particles.particleBirthRate = 0
        addChild(particles)
        self.particles = particles
    }
    
    func update(_ currentTime: TimeInterval) {
        if !isDead { position.x += 8 }
        if position.x > 400 { die() }
        if isDead {
            if particles?.particleBirthRate ?? 0 <= 0 {
                removeFromParent()
            }
            particles?.particleBirthRate -= 4
        }
    }
    
    func didCollide(with node: SKNode?) {
        die()
    }
    
    func die() {
        guard !isDead else { return }
        isDead = true
        zRotation = 0
        position.x += 32
        physicsBody = nil
        particles?.particleBirthRate = 48
        texture = SKTexture(imageNamed: "invisible")
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
            return SKTexture(imageNamed: "bullet")
        case .sword:
            return SKTexture(imageNamed: "s.weapons.sword")
        }
    }
    
    func size() -> CGSize {
        switch self {
        case .standard:
            return CGSize(width: 36, height: 36)
        case .sword:
            return CGSize(width: 72, height: 72)
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
            return .angelBlue
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
    
    func particles() -> SKEmitterNode? {
        switch self {
        case .standard:
            return SKEmitterNode(fileNamed: "BlueSpark")
        case .sword:
            return SKEmitterNode(fileNamed: "RedSmoke")
        }
    }
}
