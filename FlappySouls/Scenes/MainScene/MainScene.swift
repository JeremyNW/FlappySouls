//
//  MainScene.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/1/22.
//

import Foundation
import SpriteKit
import GameKit
import UIKit

class MainScene: SKScene {
    
    var infoButton: GameButton?
    var playButton: GameButton?
    var watchButton: GameButton?
    var purchaseButton: GameButton?
    var bossButton: GameButton?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        infoButton = childNode(withName: "InfoButton") as? GameButton
        playButton = childNode(withName: "PlayButton") as? GameButton
        watchButton = childNode(withName: "WatchButton") as? GameButton
        purchaseButton = childNode(withName: "PurchaseButton") as? GameButton
        bossButton = childNode(withName: "BossButton") as? GameButton
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(isWaiting), name: .init("Waiting"), object: nil)

        infoButton?.setUp(theme: .secondary) {
            NotificationCenter.default.post(name: .init("Info"), object: nil)
        }
        

        playButton?.setUp(theme: .primary) {
            guard let scene = SKScene(fileNamed: "GameScene") else { return }
            scene.scaleMode = .aspectFit
            view.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 0.4))
        }
        bossButton?.setUp(theme: .secondary, action: {
            guard let scene = SKScene(fileNamed: "BossScene") as? GameScene else { return }
            scene.scaleMode = .aspectFit
            scene.state.isBossMode = true
            view.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 0.4))
        })
        
        if Persistence.shared.getBool(.isPurchased) || GameState.isFullscreen {
            watchButton?.isHidden = true
            purchaseButton?.isHidden = true
            playButton?.position.y = 0
        } else {
            watchButton?.setUp(theme: .secondary) {
                let notificationName = Notification.Name("fullscreen")
                let notification = Notification(name: notificationName)
                NotificationCenter.default.post(notification)
            }
            purchaseButton?.setUp(theme: .secondary) {
                PurchaseController.shared.buyFullscreen()
                
            }
        }
        
        Leaderboards.shared.load()
        
        
    }

    @objc func isWaiting() {
        self.watchButton?.setText("Please wait...")
    }
    
}
