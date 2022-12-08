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
    var shieldIFrames = 15
    
    func setUp(for state: GameState) {
        guard
            let upZero = childNode(withName: "SKWingUp0") as? SKSpriteNode,
            let upOne = childNode(withName: "SKWingUp1") as? SKSpriteNode,
            let downZero = childNode(withName: "SKWingDown0"),
            let downOne = childNode(withName: "SKWingDown1")
        else { return }
        colorBlendFactor = 1
        upWings = [upZero, upOne]
        downWings = [downZero, downOne]
        standardRotation = zRotation
        self.state = state
        self.shieldAura = childNode(withName: "ShieldAura")
    }
    
    func update(_ currentTime: TimeInterval) {
        color = state.isDead ? .darkGray :
        state.powerupCooldown > 0 ? .green :
        state.swords > 0 ? .red :
        state.isShielded ? .cyan : .white
        shieldAura?.isHidden = !state.isShielded
        position.y += yVelocity
        yVelocity -= 0.48
        if position.y < -600 || position.y > 620 {
            state.isDead = true
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
        
        if yVelocity <= -10 {
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
    }
    
    
    func didCollide(with node: SKNode?) {
        if state.isShielded || shieldIFrames > 0 {
            state.isShielded = false
            return
        }
        state.isDead = true
        state.sendHapticFeedback(.heavy)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !state.isDead else { return }
        yVelocity = 10
        
    }
}
