//
//  GameScene.swift
//  FlappySouls
//
//  Created by Jeremy Warren on 11/27/22.
//

import SpriteKit
import GameplayKit

protocol GameObject {
    func setUp(for state: GameState)
    func update(_ currentTime: TimeInterval)
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func didCollide(with node: SKNode?)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var state = GameState()
    var objects: [GameObject] { getGameObjects(for: self) }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        objects.forEach { $0.setUp(for: state) }
        state.scene = self
    }
    
    override func update(_ currentTime: TimeInterval) {
        state.update(currentTime)
        objects.forEach { $0.update(currentTime) }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        objects.forEach { $0.touchesBegan(touches, with: event) }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let a = contact.bodyA.node
        let b = contact.bodyB.node
        (a as? GameObject)?.didCollide(with: b)
        (b as? GameObject)?.didCollide(with: a)
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

