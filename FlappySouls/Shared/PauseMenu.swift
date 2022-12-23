//
//  PauseMenu.swift
//  FlappySouls
//
//  Created by Jared Warren on 12/11/22.
//

import Foundation
import SpriteKit

protocol PauseMenuDataSource: AnyObject {
  var isDead: Bool { get set }
  var isPaused: Bool { get set }
}

class PauseMenu: SKNode, GameObject {
  weak var dataSource: PauseMenuDataSource!
  var label: SKNode?
  var button: GameButton?
  
  func setUp(for state: GameState) {
    self.dataSource = state as? PauseMenuDataSource
    button = childNode(withName: "PauseButton") as? GameButton
    button?.setUp(theme: .secondary) { [weak self] in
      self?.label?.isHidden.toggle()
      self?.scene?.isPaused.toggle()
    }
    label = childNode(withName: "PauseLabel")
    label?.isHidden = true
  }
  
  func update(_ currentTime: TimeInterval) {
    button?.isHidden = dataSource.isDead
    label?.isHidden = scene?.isPaused == false
  }
  
  func didCollide(with node: SKNode?) {
    
  }
}
