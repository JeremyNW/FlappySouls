//
//  GameScene.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/27/22.
//

import SpriteKit
import GameplayKit

protocol GameObject {
    func setUp(with controller: GameController)
    func update(_ currentTime: TimeInterval)
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func didCollide(with body: SKPhysicsBody)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var controller = GameController()
    var objects: [GameObject] { getGameObjects(for: self) }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        objects.forEach { $0.setUp(with: controller) }
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
    
    // finds every GameObject in the scene by recursively searching all nodes
    private func getGameObjects(for node: SKNode) -> [GameObject] {
        var objects: [GameObject] = []
        for child in node.children {
            objects.append(contentsOf: getGameObjects(for: child))
        }
        if let object = node as? GameObject {
            objects.append(object)
        }
        return objects
    }
    
}

