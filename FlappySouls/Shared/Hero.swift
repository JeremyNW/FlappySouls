//
//  Hero.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/27/22.
//

import Foundation
import SpriteKit

protocol AngelDataSource: AnyObject {
    var heroPosition: CGPoint { get set }
    var isDead: Bool { get set}
    var isShielded: Bool { get set }
    var slainWithShield: Int { get set }
    var swords: Int { get set }
    func tearDown()
}

class Hero: SKSpriteNode, GameObject {
    let textures: [SKTexture] = [
        SKTexture(imageNamed: "wing0"),
        SKTexture(imageNamed: "wing1"),
        SKTexture(imageNamed: "wing2"),
        SKTexture(imageNamed: "wing3"),
    ]
    var bulletTimer: Int = 15
    weak var dataSource: AngelDataSource!
    var yVelocity = CGFloat(0)
    var upWings: [SKSpriteNode] = []
    var downWings: [SKNode] = []
    var standardRotation = CGFloat(0)
    var shieldAura: SKNode?
    var halo: SKEmitterNode?
    var shieldIFrames = 15
    
    func setUp(for state: GameState) {
        guard
            let upZero = childNode(withName: "SKWingUp0") as? SKSpriteNode,
            let upOne = childNode(withName: "SKWingUp1") as? SKSpriteNode,
            let downZero = childNode(withName: "SKWingDown0"),
            let downOne = childNode(withName: "SKWingDown1"),
            let halo = SKEmitterNode(fileNamed: "Halo")
        else { return }
        upWings = [upZero, upOne]
        downWings = [downZero, downOne]
        standardRotation = zRotation
        addChild(halo)
        halo.position = CGPoint(x: 8, y: 56)
        halo.zPosition = 1
        halo.particleBirthRate = 0
        self.halo = halo
        self.dataSource = state as? AngelDataSource
        self.shieldAura = childNode(withName: "ShieldAura")
        run(.changeVolume(to: 0.1, duration: .greatestFiniteMagnitude))
    }
    
    func update(_ currentTime: TimeInterval) {
        dataSource.heroPosition = position
        shieldAura?.isHidden = !dataSource.isShielded
        position.y += yVelocity
        yVelocity -= dataSource.isDead ? 0.24 : 0.48
        if position.y < -640 || position.y > 640 {
            die()
        }
        
        if yVelocity < 8 {
            downWings.forEach { $0.isHidden = true }
            let index = yVelocity < 6 ? 0 : yVelocity < 7 ? 3 : 2
            for wing in upWings {
                wing.isHidden = false
                wing.texture = textures[index]
            }
        } else {
            downWings.forEach { $0.isHidden = false }
            upWings.forEach { $0.isHidden = true }
        }
        if bulletTimer <= 0,
           !dataSource.isDead,
           let state = dataSource as? GameState {
            let bullet = Bullet()
            scene?.addChild(bullet)
            bullet.position.x = self.position.x + 32
            bullet.position.y = self.position.y
            bullet.setUp(for: state)
            bulletTimer = 15
            
        }
        
        if yVelocity <= -12 {
            zRotation = standardRotation + yVelocity
        } else {
            zRotation = standardRotation
        }
        if dataSource.isShielded {
            shieldIFrames = 5
        } else {
            shieldIFrames -= 1
        }
        bulletTimer -= 1
        halo?.particleBirthRate = CGFloat(dataSource.swords * 2)
    }
    
    
    func didCollide(with node: SKNode?) {
        guard node != nil && !(node is PowerUp) else { return }
        
        if dataSource.isShielded || shieldIFrames > 0 {
            dataSource.isShielded = false
            dataSource.slainWithShield += 1
            run(.playSoundFileNamed("shieldOff.wav", waitForCompletion: false))
            Haptics.sendFeedback(.soft)
            return
        }
        die()
    }
    
    func die() {
        if !dataSource.isDead {
            dataSource.isDead = true
            Haptics.sendFeedback(.heavy)
            color = .darkGray
            colorBlendFactor = 1
            physicsBody = nil
            dataSource.tearDown()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !dataSource.isDead else { return }
        yVelocity = 10
        run(.playSoundFileNamed("flap\(Int.random(in: 0...4)).wav", waitForCompletion: false))
    }
}
