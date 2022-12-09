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
   
    var playButton: GameButton?
    var watchButton: GameButton?
    var purchaseButton: GameButton?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
     
        playButton = childNode(withName: "PlayButton") as? GameButton
        watchButton = childNode(withName: "WatchButton") as? GameButton
        purchaseButton = childNode(withName: "PurchaseButton") as? GameButton
        
      playButton?.setUp(isProminent: true) {
            guard let scene = SKScene(fileNamed: "GameScene") else { return }
            scene.scaleMode = .aspectFit
            view.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 0.4))
        }
        
        watchButton?.setUp {
            let notificationName = Notification.Name("fullscreen")
            let notification = Notification(name: notificationName)
            NotificationCenter.default.post(notification)
        }
        purchaseButton?.setUp {   PurchaseController.shared.buyFullscreen() }
    }
   
}
