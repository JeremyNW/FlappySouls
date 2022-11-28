//
//  GameScene.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/27/22.
//

import SpriteKit
import GameplayKit

protocol GameObject {
    func setUp()
    func update(_ currentTime: TimeInterval)
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func didCollide(with body: SKPhysicsBody)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var objects: [GameObject] = []
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        objects = children.compactMap { $0 as? GameObject }
        objects.forEach { $0.setUp() }
    }
    
    override func update(_ currentTime: TimeInterval) {
        objects.forEach { $0.update(currentTime) }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        objects.forEach { $0.touchesBegan(touches, with: event) }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        (contact.bodyA.node as? GameObject)?.didCollide(with: contact.bodyB)
        (contact.bodyB.node as? GameObject)?.didCollide(with: contact.bodyA)
    }
    
}

