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
      let scene = SKScene(fileNamed: "GameScene")
      scene?.scaleMode = .aspectFit
      view.presentScene(scene)
    }
    watchButton?.setUp { print("watch") }
    purchaseButton?.setUp { print("purchase") }
  }
}
