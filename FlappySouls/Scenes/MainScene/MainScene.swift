//
//  MainScene.swift
//  FlappySouls
//
//  Created by Paola Warren on 12/1/22.
//

import Foundation
import SpriteKit

class MainScene: SKScene {
  var playButton: GameButton?
  var watchButton: GameButton?
  var purchaseButton: GameButton?
  
  override func didMove(to view: SKView) {
    super.didMove(to: view)
    playButton = childNode(withName: "PlayButton") as? GameButton
    watchButton = childNode(withName: "WatchButton") as? GameButton
    purchaseButton = childNode(withName: "PurchaseButton") as? GameButton
    
    playButton?.isUserInteractionEnabled = true
    watchButton?.isUserInteractionEnabled = true
    purchaseButton?.isUserInteractionEnabled = true
    
    playButton?.setUp {
      guard let scene = SKScene(fileNamed: "GameScene") else { return }
      scene.scaleMode = .aspectFit
      view.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 0.4))
    }
    watchButton?.setUp { print("watch") }
    purchaseButton?.setUp { print("purchase") }
  }
}
