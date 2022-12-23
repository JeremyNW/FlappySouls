//
//  DeathCover.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/6/22.
//

import Foundation
import SpriteKit

protocol DeathMenuDataSource: AnyObject {
    var isDead: Bool { get }
}

class DeathMenu: SKNode, GameObject {
    weak var dataSource: DeathMenuDataSource!
    func setUp(for state: GameState) {
        self.dataSource = state as? DeathMenuDataSource
        let playAgainButton = childNode(withName: "PlayAgain") as? GameButton
        let mainMenuButton = childNode(withName: "MainMenu") as? GameButton

        playAgainButton?.setUp(theme: .primary) { [weak self] in
            guard
                let filename = self?.scene?.name,
                let scene = SKScene(fileNamed: filename)
            else { return }
            scene.scaleMode = .aspectFit
            self?.scene?.view?.presentScene(scene, transition: .flipHorizontal(withDuration: 0.4))
        }

        mainMenuButton?.setUp(theme: .secondary) { [weak self] in
            guard let scene = SKScene(fileNamed: "MainScene") else { return }
            scene.scaleMode = .aspectFit
            self?.scene?.view?.presentScene(scene, transition: .doorsCloseHorizontal(withDuration: 0.4))
        }
    }
    
    func update(_ currentTime: TimeInterval) {
        isHidden = !dataSource.isDead
    }
    
    func didCollide(with node: SKNode?) {
        
    }
}
