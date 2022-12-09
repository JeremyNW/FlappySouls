//
//  Hero.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/27/22.
//

import Foundation
import SpriteKit

class Hero: SKSpriteNode, GameObject {
    let textures: [SKTexture] = [
        SKTexture(imageNamed: "wing0"),
        SKTexture(imageNamed: "wing1"),
        SKTexture(imageNamed: "wing2"),
        SKTexture(imageNamed: "wing3"),
    ]
    var timer: Int = 15
    var state: GameState!
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
        self.state = state
        self.shieldAura = childNode(withName: "ShieldAura")
        run(.changeVolume(to: 0.1, duration: .greatestFiniteMagnitude))
    }
    
    func update(_ currentTime: TimeInterval) {
        shieldAura?.isHidden = !state.isShielded
        position.y += yVelocity
        yVelocity -= 0.48
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
        if timer == 0,
           !state.isDead,
        let state {
            let bullet = Bullet()
            scene?.addChild(bullet)
            bullet.position.x = self.position.x + 32
            bullet.position.y = self.position.y
            bullet.setUp(for: state)
            timer = 15
        }
        
        if yVelocity <= -12 {
            zRotation = standardRotation + yVelocity
        } else {
            zRotation = standardRotation
        }
        if state.isShielded {
            shieldIFrames = 15
        } else {
            shieldIFrames -= 1
        }
        timer -= 1
        halo?.particleBirthRate = CGFloat(state.swords * 2)
    }
    
    
    func didCollide(with node: SKNode?) {
        if state.isShielded || shieldIFrames > 0 {
            state.isShielded = false
            run(.playSoundFileNamed("shieldOff.wav", waitForCompletion: false))
            state.sendHapticFeedback(.soft)
            return
        }
        die()
    }
    
    func die() {
        if !state.isDead {
            state.isDead = true
            state.sendHapticFeedback(.heavy)
            color = .darkGray
            colorBlendFactor = 1
            physicsBody = nil
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !state.isDead else { return }
        yVelocity = 10
        run(.playSoundFileNamed("flap\(Int.random(in: 0...4)).wav", waitForCompletion: false))
    }
}
