//
//  MainScene.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/1/22.
//

import Foundation
import SpriteKit
import StoreKit

class MainScene: SKScene {
    
    var infoButton: GameButton?
    var playButton: GameButton?
    var watchButton: GameButton?
    var purchaseButton: GameButton?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        infoButton = childNode(withName: "InfoButton") as? GameButton
        playButton = childNode(withName: "PlayButton") as? GameButton
        watchButton = childNode(withName: "WatchButton") as? GameButton
        purchaseButton = childNode(withName: "PurchaseButton") as? GameButton
        
        infoButton?.setUp(theme: .light) {
            NotificationCenter.default.post(name: .init("Info"), object: nil)
        }
        
        playButton?.setUp(theme: .purple) {
            guard let scene = SKScene(fileNamed: "GameScene") else { return }
            scene.scaleMode = .aspectFit
            view.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 0.4))
        }
        
        if UserDefaults.standard.bool(forKey: "purchased") {
            watchButton?.isHidden = true
            purchaseButton?.isHidden = true
            playButton?.position.y = -196
        } else {
            watchButton?.setUp(theme: .light) {
                let notificationName = Notification.Name("fullscreen")
                let notification = Notification(name: notificationName)
                NotificationCenter.default.post(notification)
                self.watchButton?.setText("Please wait...")
            }
            purchaseButton?.setUp(theme: .light) { PurchaseController.shared.buyFullscreen() }
        }
    }
    
}
