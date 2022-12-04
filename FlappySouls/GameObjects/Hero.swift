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
    var controller: GameController!
    var yVelocity = CGFloat(0)
    var upWings: [SKSpriteNode] = []
    var downWings: [SKNode] = []
    var standardRotation = CGFloat(0)
    
    func setUp(with controller: GameController) {
        guard
            let upZero = childNode(withName: "SKWingUp0") as? SKSpriteNode,
            let upOne = childNode(withName: "SKWingUp1") as? SKSpriteNode,
            let downZero = childNode(withName: "SKWingDown0"),
            let downOne = childNode(withName: "SKWingDown1")
        else { return }
        upWings = [upZero, upOne]
        downWings = [downZero, downOne]
        standardRotation = zRotation
        self.controller = controller
    }
    
    func update(_ currentTime: TimeInterval) {
     
        position.y += yVelocity
        yVelocity -= 0.25
        if position.y < -600 {
            yVelocity = 0
        }
        if position.y > 620 {
            yVelocity = 0
            position.y = 620
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
        if timer == 0 {
            let bullet = Bullet()
            scene?.addChild(bullet)
            bullet.position.x = self.position.x + 32
            bullet.position.y = self.position.y
            if let controller = controller {
                bullet.setUp(with: controller)
            }
            timer = 15
        }
        
        if yVelocity <= -10 {
            zRotation = standardRotation + yVelocity
        } else {
            zRotation = standardRotation
        }
        
        timer -= 1
    }
    
    
    func didCollide(with body: SKPhysicsBody) {
      scene?.view?.presentScene(SKScene(fileNamed: "MainScene"))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        yVelocity = 10
        
    }
}
