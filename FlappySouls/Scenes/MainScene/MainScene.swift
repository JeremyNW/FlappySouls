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
        
        if FeatureFlags.isBossModeEnabled {
            bossButton?.setUp(theme: .secondary) {
                guard let scene = SKScene(fileNamed: "BossScene") else { return }
                scene.scaleMode = .aspectFit
                view.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 0.4))
            }
        } else {
            bossButton?.isHidden = true
            watchButton?.position.y += 140
            purchaseButton?.position.y += 140
        }
        
        GameNotification.addObserver(self, notification: .waiting, selector: #selector(isWaiting))

        infoButton?.setUp(theme: .secondary) {
            GameNotification.post(.info)
        }
        playButton?.setUp(theme: .primary) {
            guard let scene = SKScene(fileNamed: "PlayScene") else { return }
            scene.scaleMode = .aspectFit
            view.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 0.4))
        }
        
        if Persistence.shared.getBool(.isPurchased) || Advertisement.isDisabled {
            watchButton?.isHidden = true
            purchaseButton?.isHidden = true
        } else {
            watchButton?.setUp(theme: .secondary) {
                GameNotification.post(.fullscreen)
            }
            purchaseButton?.setUp(theme: .secondary) {
                Purchases.shared.buyFullscreen()
            }
        }
        Leaderboards.shared.load()
    }

    @objc func isWaiting() {
        self.watchButton?.setText("Please wait...")
    }
    
}
