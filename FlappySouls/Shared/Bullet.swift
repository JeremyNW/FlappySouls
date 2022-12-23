//
//  Bullet.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/29/22.
//

import Foundation
import SpriteKit

protocol BulletDataSource: AnyObject {
    var attackedWithSword: Int { get set }
    var power: Int { get }
    var swords: Int { get set }
}

class Bullet: SKSpriteNode, GameObject {
    weak var dataSource: BulletDataSource!
    var damage: Int = 1
    var isDead = false
    var particles: SKEmitterNode?
    
    func setUp(for state: GameState) {
        self.dataSource = state as? BulletDataSource
        
        let type = BulletType.getType(for: dataSource)
        damage = type.damage(for: dataSource)
        size = type.size()
        texture = type.texture()
        color = type.color()
        zPosition = 0
        colorBlendFactor = 1
        if type == .sword {
            dataSource.attackedWithSword += 1
        }
        
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
        if !isDead { position.x += 6 }
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
    
    static func getType(for dataSource: BulletDataSource) -> BulletType {
        if dataSource.swords > 0 {
            dataSource.swords -= 1
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
    
    func damage(for dataSource: BulletDataSource) -> Int {
        switch self {
        case .standard:
            return dataSource.power
        case .sword:
            return dataSource.power * 2
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
    
    func particles() -> SKEmitterNode? {
        switch self {
        case .standard:
            return SKEmitterNode(fileNamed: "BlueSpark")
        case .sword:
            return SKEmitterNode(fileNamed: "RedSmoke")
        }
    }
}
